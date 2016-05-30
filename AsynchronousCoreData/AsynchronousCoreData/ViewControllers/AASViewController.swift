//
//  AASViewController.swift
//  AsynchronousCoreData
//
//  Created by Frank Saar on 29/05/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//

import UIKit
import CoreData

class AASViewController: UIViewController {
    private var asyncBatchUpdateObserver : AASKeyValueObserver?
    override func viewDidLoad() {
        super.viewDidLoad()
        rebuildIfNeedBe()
    }
}

/// MARK: Button Handlers
private extension AASViewController {
    
    @IBAction func asyncFetchRequest() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let managedObjectContext = AASCoreDataStack.sharedDataStack.managedObjectContext
        managedObjectContext.reset()
        let fetchRequest = NSFetchRequest(entityName:"AASWeatherData")
        fetchRequest.includesPropertyValues = true
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { results in
            if let results = results.finalResult {
                print("async fetch time: %f (results:\(results.count) \(results.first)",CFAbsoluteTimeGetCurrent()-startTime)
                managedObjectContext.reset()
            }
        }
        _ = try! managedObjectContext.executeRequest(asyncRequest)
    }
    
    @IBAction func asyncCancelledFetchRequest() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let managedObjectContext = AASCoreDataStack.sharedDataStack.managedObjectContext
        managedObjectContext.reset()
        let fetchRequest = NSFetchRequest(entityName:"AASWeatherData")
        fetchRequest.includesPropertyValues = true
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { results in
            let cancelled = results.progress?.cancelled
            
            if let results = results.finalResult {
                if (cancelled ?? false)
                {
                    print("cancelled")
                }
                print("async fetch time: %f (results:\(results.count) \(results.first)",CFAbsoluteTimeGetCurrent()-startTime)
                managedObjectContext.reset()
            }
        }
        let progress = NSProgress(totalUnitCount: 1)
        progress.becomeCurrentWithPendingUnitCount(1)
        let request = try! managedObjectContext.executeRequest(asyncRequest) as! NSPersistentStoreAsynchronousResult
        progress.resignCurrent()
        let newProgress = request.progress!
        newProgress.cancel()
    }
    
    
    @IBAction func syncFetchRequest() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let managedObjectContext = AASCoreDataStack.sharedDataStack.managedObjectContext
        managedObjectContext.reset()
        let fetchRequest = NSFetchRequest(entityName:"AASWeatherData")
        fetchRequest.includesPropertyValues = true
        let results = try! managedObjectContext.executeFetchRequest(fetchRequest)
        print("sync fetch time: %f (results:\(results.count) \(results.first)",CFAbsoluteTimeGetCurrent()-startTime)
        managedObjectContext.reset()
    }
    
    @IBAction func asyncBatchUpdateRequest() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let managedObjectContext = AASCoreDataStack.sharedDataStack.managedObjectContext
        managedObjectContext.reset()
        
        let asyncRequest = NSBatchUpdateRequest(entityName: "AASWeatherData")
        asyncRequest.resultType = .UpdatedObjectIDsResultType
        asyncRequest.propertiesToUpdate = [ "location" : "London" ]
        asyncRequest.predicate = NSPredicate(format: "location == %@","heathrow")
        let progress = NSProgress(totalUnitCount: 1)
        progress.becomeCurrentWithPendingUnitCount(1)
        let batchUpdateResult = try! managedObjectContext.executeRequest(asyncRequest) as! NSBatchUpdateResult
        self.asyncBatchUpdateObserver = AASKeyValueObserver(target: progress, keyPath: "completedUnitCount") { keyPath, dict in
            let completedUnitCount = dict![NSKeyValueChangeNewKey] as! Int
            if (completedUnitCount == 1)
            {
                print("async update time: %f",CFAbsoluteTimeGetCurrent()-startTime)
                print("\(batchUpdateResult.result!.count) updates")
                if let objectIDs = batchUpdateResult.result as? [AnyObject] where !objectIDs.isEmpty {
                    let fetchRequest = NSFetchRequest(entityName:"AASWeatherData")
                    fetchRequest.includesPropertyValues = true
                    fetchRequest.predicate = NSPredicate(format: "self in %@",objectIDs)
                    let updatedObjects = try! managedObjectContext.executeFetchRequest(fetchRequest)
                    print("retrieved updated objects: %@",updatedObjects.first)
                }
                
            }
        }
        progress.resignCurrent()
    }
    
    @IBAction func syncBatchUpdateRequest() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let managedObjectContext = AASCoreDataStack.sharedDataStack.managedObjectContext
        managedObjectContext.reset()
        
        let fetchRequest = NSFetchRequest(entityName:"AASWeatherData")
        fetchRequest.includesPropertyValues = true
        fetchRequest.predicate = NSPredicate(format: "location == %@","heathrow")
        let objects = try! managedObjectContext.executeFetchRequest(fetchRequest) as! [AASWeatherData]
        for object in objects {
            object.location = "London"
        }
        try! managedObjectContext.save()
        print("sync update time: %f",CFAbsoluteTimeGetCurrent()-startTime)
        
    }
    
    @IBAction func asyncDeletionRequest() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let managedObjectContext = AASCoreDataStack.sharedDataStack.managedObjectContext
        managedObjectContext.reset()
        
        let fetchRequest = NSFetchRequest(entityName:"AASWeatherData")
        fetchRequest.includesPropertyValues = true
        fetchRequest.predicate = NSPredicate(format: "location == %@","heathrow")
        
        let asyncRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        asyncRequest.resultType = .ResultTypeCount
        let progress = NSProgress(totalUnitCount: 1)
        progress.becomeCurrentWithPendingUnitCount(1)
        let batchUpdateResult = try! managedObjectContext.executeRequest(asyncRequest) as! NSBatchDeleteResult
        self.asyncBatchUpdateObserver = AASKeyValueObserver(target: progress, keyPath: "completedUnitCount") { keyPath, dict in
            let completedUnitCount = dict![NSKeyValueChangeNewKey] as! Int
            if (completedUnitCount == 1)
            {
                print("async deletion time: %f",CFAbsoluteTimeGetCurrent()-startTime)
                print("\(batchUpdateResult.result!) objects deleted")
            }
        }
        progress.resignCurrent()
    }
    
    @IBAction func syncDeleteRequest() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let managedObjectContext = AASCoreDataStack.sharedDataStack.managedObjectContext
        managedObjectContext.reset()
        
        let fetchRequest = NSFetchRequest(entityName:"AASWeatherData")
        fetchRequest.includesPropertyValues = true
        fetchRequest.predicate = NSPredicate(format: "location == %@","heathrow")
        let objects = try! managedObjectContext.executeFetchRequest(fetchRequest) as! [AASWeatherData]
        for object in objects {
            managedObjectContext.deleteObject(object)
        }
        try! managedObjectContext.save()
        print("sync deletion time: %f",CFAbsoluteTimeGetCurrent()-startTime)
        
    }
    
    @IBAction func rebuild() {
        AASCoreDataStack.sharedDataStack.flush()
        let managedObjectContext = AASCoreDataStack.sharedDataStack.managedObjectContext
        let parser = AASWeatherParser(fileName: "AASWeatherData",parseBlock: parseWeather)
        parser.parse()
        try! managedObjectContext.save()
        managedObjectContext.reset()
        let fetchRequest = NSFetchRequest(entityName:"AASWeatherData")
        fetchRequest.includesPropertyValues = true
        let newCount = managedObjectContext.countForFetchRequest(fetchRequest, error: nil)
        print("\(newCount) entries in database")
        
    }
}

/// MARK: Helper
private extension AASViewController {
    func parseWeather(elements : [String]) {
        let tuple = (elements[0],elements[1],elements[2],elements[3],elements[4],elements[5],elements[6],elements[7]);
        let (location,year,month,maxTemp,minTemp,airFrost,rainInMM,sunHours) = tuple
        let context = AASCoreDataStack.sharedDataStack.managedObjectContext
        _ = AASWeatherData.data(context, location: location, year: Int(year)!, month: Int(month)!, maxTemp: Float(maxTemp)!, minTemp: Float(minTemp)!, airFrost: Int(airFrost), rainInMM: Float(rainInMM), sunHours: sunHours)
        
    }
    
    func rebuildIfNeedBe() {
        let fetchRequest = NSFetchRequest(entityName: "AASWeatherData")
        let context = AASCoreDataStack.sharedDataStack.managedObjectContext
        let count = context.countForFetchRequest(fetchRequest, error: nil)
        if count == 0 {
            rebuild()
        }
    }
}
