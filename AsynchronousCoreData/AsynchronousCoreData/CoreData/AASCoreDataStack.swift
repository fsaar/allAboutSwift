
import Foundation
import CoreData

@objc public final class AASCoreDataStack : NSObject {
    
    static let sharedDataStack = AASCoreDataStack()
    public private(set) var managedObjectContext : NSManagedObjectContext
    private var storeCoordinator : NSPersistentStoreCoordinator

    override init() {
        
        let models = NSManagedObjectModel.mergedModelFromBundles(nil)!
        storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: models)
        let storeURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!.URLByAppendingPathComponent("AsyncCoreData.sqlite")
        let dict : [String : AnyObject] = [ NSPersistentStoreFileProtectionKey : NSFileProtectionComplete ,
                                            NSMigratePersistentStoresAutomaticallyOption : true,
                                            NSInferMappingModelAutomaticallyOption : true]
        _ = try! storeCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: dict)
        managedObjectContext =  NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType);
        managedObjectContext.persistentStoreCoordinator = storeCoordinator  
        super.init()
    }
    
    func flush() {
        let storeURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!.URLByAppendingPathComponent("AsyncCoreData.sqlite")
        self.managedObjectContext.reset()
        try! self.storeCoordinator.removePersistentStore(self.storeCoordinator.persistentStores.first!)
        try! NSFileManager.defaultManager().removeItemAtURL(storeURL)
        let models = NSManagedObjectModel.mergedModelFromBundles(nil)!
        self.storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: models)
        let dict : [String : AnyObject] = [ NSPersistentStoreFileProtectionKey : NSFileProtectionComplete ,
                                            NSMigratePersistentStoresAutomaticallyOption : true,
                                            NSInferMappingModelAutomaticallyOption : true]
        try! storeCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: dict)
        self.managedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        self.managedObjectContext.persistentStoreCoordinator = self.storeCoordinator
    }
    
}


