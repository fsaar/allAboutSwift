import Foundation
import UIKit
import XCPlayground

public func viewWithColor(color: UIColor,rect : CGRect = .zero) -> UIView {
    let view = UIView(frame: .zero)
    view.backgroundColor = color
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}

public func playgroundWithWindow(rect : CGRect) -> UIView {
    let window = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
    window.clipsToBounds = false
    window.backgroundColor = UIColor.whiteColor()
    XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
    XCPlaygroundPage.currentPage.liveView = window
    return window
}
