import Foundation
import UIKit

public typealias PlaygroundButtonTouchHandler = (button : UIButton) -> ()

public class PlaygroundButton : UIButton {
    public var touchHandler : PlaygroundButtonTouchHandler?
    public override init(frame : CGRect) {
        super.init(frame : .zero)
        self.addTarget(self, action: #selector(touchUpInsideHandler(_:)), forControlEvents: .TouchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func touchUpInsideHandler(button : UIButton) {
        touchHandler?(button : button)
    }
    
}