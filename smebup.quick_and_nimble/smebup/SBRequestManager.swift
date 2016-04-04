//
//  SBRequestManager.swift
//  smebup
//
//  Created by Frank Saar on 16/02/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//

import Foundation

/*
https://api.tfl.gov.uk/Journey/Meta/0?app_id=528a18f1&app_key=86f44a61de39e94b3738d9fe6cfcdf35


https://api.tfl.gov.uk/Place/Type/jamcam?activeOnly=false&
*/



private let SBRequestManagerBaseURL = "https://api.tfl.gov.uk"


private let SBApplicationID = "528a18f1"
private let SBApplicationKey = "86f44a61de39e94b3738d9fe6cfcdf35"

private enum SBRequestManagerURLType : String {
    case PlacesURL = "/Place/Type/jamcam"
}


enum SBRequestManagerErrorType : ErrorType {
    case InvalidURL(urlString : String)
}


public class SBRequestManager {
    
    
    static let sharedManager = SBRequestManager()
    
    convenience init(session : NSURLSession) {
        self.init()
        self.session = session
    }
    
    lazy private var session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    public func tflCameraList(completionBlock:(([SBJamCamListEntry]?,error:NSError?) -> ())?) throws {
        try tflDataWithRelativeURL(.PlacesURL) { data, error in
            if let data = data,
                jsonArray = try? NSJSONSerialization.JSONObjectWithData(data
                    , options: NSJSONReadingOptions(rawValue:0)) as! [[String : AnyObject]] {
                        NSOperationQueue.onMainThread {
                            completionBlock?(SBJamCamListEntry.modelsFromJSONArray(jsonArray),error: nil)
                        }
                       
            }
            else {
                NSOperationQueue.onMainThread {
                    completionBlock?(nil,error:error)
                }
            }
        }
    }

    private func tflDataWithRelativeURL(relativeURL: SBRequestManagerURLType , completionBlock:((data : NSData?,error:NSError?) -> Void)) throws {
        guard let url =  self.relativeURL(relativeURL.rawValue) else {
            throw SBRequestManagerErrorType.InvalidURL(urlString: relativeURL.rawValue)
        }
        try tflDataWithURL(url,completionBlock: completionBlock)
    }

    public func tflDataWithURL(URL: NSURL , completionBlock:((data : NSData?,error:NSError?) -> Void)) throws {
        let task = session.dataTaskWithURL(URL) { data, response , error in
            completionBlock(data: data,error: error)
        }
        task.resume()
    }

}


// MARK : Private

extension SBRequestManager {
    private func relativeURL(path: String) -> NSURL? {
        let baseURL = NSURLComponents(string: SBRequestManagerBaseURL)
        if let baseURL = baseURL {
            baseURL.path = path
            baseURL.query = "app_id=\(SBApplicationID)&app_key=\(SBApplicationKey)"
            return baseURL.URL
        }
        return nil
    }
    
}