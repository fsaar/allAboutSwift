//
//  SBImageCache.swift
//  smebup
//
//  Created by Frank Saar on 17/02/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//
import UIKit
import Foundation

typealias SBImageCacheCompletionBlock = (image : UIImage?, urlString : String) -> Void

extension NSOperationQueue {
    class func onMainThread(block : () -> Void) {
        NSOperationQueue.mainQueue().addOperationWithBlock(block)
    }
}

final public class SBImageCache {
    private let cache = NSCache()
    
    public static let sharedCache = SBImageCache()
    
    subscript(urlString: String) -> UIImage? {
        return self.cache.objectForKey(urlString) as? UIImage
    }
    
    func image(urlString: String, completionBlock : SBImageCacheCompletionBlock) {
        if let image = self[urlString] {
            completionBlock(image: image,urlString: urlString)
        }
        else
        {
            requestImageWithURL(urlString, completionBlock: completionBlock)
        }
    }
}

// MARK: Private

extension SBImageCache {
    
    private func requestImageWithURL(urlString : String, completionBlock : SBImageCacheCompletionBlock) {
        do {
            guard let url = NSURL(string: urlString) else {
                completionBlock(image: nil,urlString: urlString)
                return
            }
            try SBRequestManager.sharedManager.tflDataWithURL(url) { [weak self] data, error in
                if let data = data, image = UIImage(data: data) {
                    self?.cache.setObject(image, forKey: urlString, cost: data.length)
                    NSOperationQueue.onMainThread {
                        completionBlock(image: image, urlString: urlString)
                    }
                }
                else
                {
                    NSOperationQueue.onMainThread {
                        completionBlock(image: nil, urlString: urlString)
                    }
                }
            }
        } catch {
            completionBlock(image: nil,urlString: urlString)
        }
    }
    

    
}