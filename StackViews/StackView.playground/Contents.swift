
import UIKit
import XCPlayground

let c = UIViewController()
let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
view.clipsToBounds = false
view.backgroundColor = UIColor.whiteColor()
XCPlaygroundPage.currentPage.liveView = view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: Create a StackView
let stackView = UIStackView(frame: .zero)
stackView.axis = .Horizontal
stackView.distribution = .Fill
stackView.spacing = 20
stackView.alignment = .Center
stackView.translatesAutoresizingMaskIntoConstraints = false
view .addSubview(stackView)

//: Setup Stackview constraints
stackView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
stackView.heightAnchor.constraintEqualToConstant(200).active = true
stackView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 0).active = true
stackView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
//: Create a Label
let label = UILabel(frame: .zero)
label.backgroundColor = UIColor.greenColor()
label.translatesAutoresizingMaskIntoConstraints = false
label.text = "Stack View test"
label.numberOfLines = 0

//: Create a sample view
let sampleView = UIView(frame: .zero)
sampleView.translatesAutoresizingMaskIntoConstraints = false
sampleView.backgroundColor = UIColor.redColor()
sampleView.widthAnchor.constraintEqualToConstant(80).active = true
sampleView.heightAnchor.constraintEqualToConstant(100).active = true

//: Create a switch
let sw = UISwitch()
sw.backgroundColor = UIColor.yellowColor()
sw.translatesAutoresizingMaskIntoConstraints = false
//: Add Views to stackview
stackView.addArrangedSubview(label)
stackView.addArrangedSubview(sampleView)
stackView.addArrangedSubview(sw)


//: Animate Hiding / Removing label
UIView .animateWithDuration(1, animations: {
    label.hidden = true
}) { _ in
    UIView .animateWithDuration(1, animations: {
        label.hidden = false
    })
}


