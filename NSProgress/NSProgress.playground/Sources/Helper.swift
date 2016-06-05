import Foundation
import UIKit

public func progressView() -> UIProgressView {
    let progressUI = UIProgressView(progressViewStyle: .Bar)
   
    progressUI.translatesAutoresizingMaskIntoConstraints = false
    progressUI.progress = 0.0
    progressUI.clipsToBounds = true
    progressUI.layer.cornerRadius = 5.0
    progressUI.heightAnchor.constraintEqualToConstant(10).active = true

    return progressUI
}


@objc public class ThreadObject : NSObject {
    let block : ()->()
    init(block : ()->()) {
        self.block = block
    }
    
    func execute(argument : AnyObject) {
        block()
    }
}

public func newThread(block : ()->()) -> NSThread {
    let block = ThreadObject(block: block)
    let selector = #selector(ThreadObject.execute(_:))
    let thread = NSThread(target: block, selector: selector , object: nil)
    return thread
}