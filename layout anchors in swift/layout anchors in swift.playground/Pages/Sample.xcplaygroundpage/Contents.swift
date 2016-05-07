//:# layout anchors in swift
import UIKit
import XCPlayground

//: Playground setup

let c = UIViewController()
let window = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
window.clipsToBounds = false
window.backgroundColor = UIColor.whiteColor()
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = window

//: Laying out views with anchors

let view1 = UIView(frame: .zero)
view1.translatesAutoresizingMaskIntoConstraints = false
view1.backgroundColor = UIColor.blueColor()
window.addSubview(view1)

view1.topAnchor.constraintEqualToAnchor(window.topAnchor,constant: 10).active = true
view1.leadingAnchor.constraintEqualToAnchor(window.leadingAnchor,constant: 10).active = true
view1.widthAnchor.constraintEqualToAnchor(window.widthAnchor, multiplier: 0.3).active = true
view1.heightAnchor.constraintEqualToAnchor(view1.widthAnchor, multiplier: 1).active = true


let view6 = UIView(frame: .zero)
view6.translatesAutoresizingMaskIntoConstraints = false
view6.backgroundColor = UIColor.yellowColor()
window.addSubview(view6)

view6.topAnchor.constraintEqualToAnchor(window.topAnchor,constant: 10).active = true
view6.leadingAnchor.constraintEqualToAnchor(view1.trailingAnchor,constant: 10).active = true
view6.widthAnchor.constraintEqualToAnchor(view1.widthAnchor, multiplier: 1).active = true
view6.heightAnchor.constraintEqualToAnchor(view1.heightAnchor, multiplier: 1).active = true



let view2 = UIView(frame: .zero)
view2.translatesAutoresizingMaskIntoConstraints = false
view2.backgroundColor = UIColor.redColor()

window.addSubview(view2)
view2.topAnchor.constraintEqualToAnchor(window.topAnchor,constant: 10).active = true
view2.trailingAnchor.constraintEqualToAnchor(window.trailingAnchor,constant: -10).active = true
view2.widthAnchor.constraintEqualToAnchor(window.widthAnchor, multiplier: 0.3).active = true
view2.heightAnchor.constraintEqualToAnchor(view2.widthAnchor, multiplier: 1).active = true

let view3 = UIView(frame: .zero)
view3.translatesAutoresizingMaskIntoConstraints = false
view3.backgroundColor = UIColor.greenColor()
window.addSubview(view3)

view3.centerYAnchor.constraintEqualToAnchor(window.centerYAnchor,constant: 0).active = true
view3.trailingAnchor.constraintEqualToAnchor(window.trailingAnchor,constant: -10).active = true
view3.widthAnchor.constraintEqualToAnchor(window.widthAnchor, multiplier: 0.3).active = true
view3.heightAnchor.constraintEqualToAnchor(view1.widthAnchor, multiplier: 1).active = true

let centerView = UIView(frame: .zero)
centerView.translatesAutoresizingMaskIntoConstraints = false
centerView.backgroundColor = UIColor.grayColor()
window.addSubview(centerView)

centerView.centerXAnchor.constraintEqualToAnchor(window.centerXAnchor).active = true
centerView.centerYAnchor.constraintEqualToAnchor(window.centerYAnchor).active = true
centerView.widthAnchor.constraintEqualToAnchor(window.widthAnchor, multiplier: 0.3).active = true
centerView.heightAnchor.constraintEqualToAnchor(centerView.widthAnchor, multiplier: 1).active = true

//: Using layout guides

let layoutGuide1 = UILayoutGuide()
window.addLayoutGuide(layoutGuide1)
layoutGuide1.widthAnchor.constraintEqualToAnchor(window.widthAnchor, multiplier: 0.3).active = true
layoutGuide1.heightAnchor.constraintEqualToConstant(1).active = true
layoutGuide1.leftAnchor.constraintEqualToAnchor(window.leftAnchor).active = true

let layoutGuide2 = UILayoutGuide()
window.addLayoutGuide(layoutGuide2)
layoutGuide2.widthAnchor.constraintEqualToAnchor(window.widthAnchor, multiplier: 0.3).active = true
layoutGuide2.heightAnchor.constraintEqualToConstant(1).active = true
layoutGuide2.rightAnchor.constraintEqualToAnchor(window.rightAnchor).active = true


let view4 = UIView(frame: .zero)
view4.translatesAutoresizingMaskIntoConstraints = false
view4.backgroundColor = UIColor.purpleColor()
window.addSubview(view4)

let bottomAnchorConstraint = view4.bottomAnchor.constraintEqualToAnchor(window.bottomAnchor)
bottomAnchorConstraint.active = true
let heightConstraint = view4.heightAnchor.constraintEqualToAnchor(window.heightAnchor, multiplier: 0.3)
heightConstraint.priority = 850
heightConstraint.active = true
let heightConstraint2 = view4.heightAnchor.constraintGreaterThanOrEqualToAnchor(window.heightAnchor, multiplier: 0.5)
heightConstraint2.priority = 700
heightConstraint2.active = true
view4.leftAnchor.constraintEqualToAnchor(layoutGuide1.rightAnchor).active = true
view4.rightAnchor.constraintEqualToAnchor(layoutGuide2.leftAnchor).active = true

