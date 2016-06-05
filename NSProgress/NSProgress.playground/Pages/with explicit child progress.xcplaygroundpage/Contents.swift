
import UIKit
import XCPlayground
//:## Progress with explicit child progress

//: - callout(Setup playground UI): setup Playground UI with a progress bar and a cancel button

let c = UIViewController()
let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
view.clipsToBounds = false
view.backgroundColor = UIColor.whiteColor()
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = view

let progressUI = progressView()
view .addSubview(progressUI)
progressUI.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
progressUI.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor,constant:10).active = true
progressUI.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor,constant: -10).active = true

let cancelButton = PlaygroundButton(frame: .zero)
cancelButton.layer.cornerRadius = 5
cancelButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
cancelButton.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(cancelButton)
cancelButton.backgroundColor = UIColor.redColor()
cancelButton.setTitle("Cancel", forState: .Normal)
cancelButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -5).active = true
cancelButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true

//: - callout(Tasks): simple counter tasks that decrements counter repeatedly til counter reaches zero. When zero call completion block

func incrementSubTask(progress : NSProgress,unitCount : Int64,completionBlock :() -> ()) {
    let queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
    dispatch_after(dispatch_time_t(100), queue) {
        if progress.cancelled
        {
            completionBlock()
        }
        guard unitCount > 0 else {
            completionBlock()
            return
        }
        incrementSubTask(progress,unitCount: unitCount-1,completionBlock: completionBlock)
    }
    
}

func doSubTaskTask(progress : NSProgress, unitCount : Int64,completionBlock : ()->()) {
    incrementSubTask(progress,unitCount: unitCount) {
        completionBlock()
    }
}

/*:
 - note: create 1000 subtasks
 / Main progress is only referenced for debugging reasons
 / child progress will implicitly be added to main progress
 */
func doMainTask(progresss : NSProgress,pendingUnitCount : Int64) {
    let subTasks = 100
    let childProgress = NSProgress(totalUnitCount: Int64(subTasks))
    progress.addChild(childProgress, withPendingUnitCount: pendingUnitCount)
    for task in 1...subTasks {
        guard !childProgress.cancelled else {
            print("Ack Cancel")
            break
        }
        doSubTaskTask(childProgress,unitCount: Int64(task)) {
            childProgress.completedUnitCount = Int64(task)
            print(progress.fractionCompleted)
        }
    }
}

/*:
 - callout(Setup Progress): create progress with 1000 units and distributes units among 'subtasks'
 */

let progress = NSProgress(totalUnitCount: 1000)
let observer = KeyValueObserver(target: progress, keyPath: "fractionCompleted") { (keyPath, dict) in
    let value = dict!["new"] as! Double
    progressUI.progress = Float(value)
}

cancelButton.touchHandler = { button in
    print ("Cancelled")
    progress.cancel()
}

doMainTask(progress,pendingUnitCount: 200)

doMainTask(progress,pendingUnitCount: 200)

doMainTask(progress,pendingUnitCount: 100)

doMainTask(progress,pendingUnitCount: 500)



