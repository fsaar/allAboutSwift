
import UIKit

public typealias AASKeyValueObserverBlock = (keyPath : String,[String : AnyObject]?)-> Void

@objc public final class AASKeyValueObserver: NSObject {
    private var slug = "KeyValueObserver"
    private let handlerBlock : AASKeyValueObserverBlock
    private var keyPath : String
    private var target : NSObject
    public init(target: NSObject,keyPath : String, handlerBlock: AASKeyValueObserverBlock)
    {
        self.keyPath = keyPath
        self.target = target
        self.handlerBlock = handlerBlock
        super.init()
        __addObserver()
    }
    
    deinit
    {
        __removeObserver()
    }
}

// MARK: Observer Handling


extension AASKeyValueObserver {
    private func __addObserver()
    {
        self.target.addObserver(self, forKeyPath: self.keyPath, options: .New, context: &self.slug)
    }
    
    private func __removeObserver()
    {
       self.target.removeObserver(self,forKeyPath: self.keyPath)
    }
    
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &self.slug, let path = keyPath where path == self.keyPath
        {
            self.handlerBlock(keyPath: path,change)
        }
        else
        {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
}
