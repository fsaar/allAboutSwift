//
//  AASWeatherData.swift
//  AsynchronousCoreData
//
//  Created by Frank Saar on 29/05/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//

import Foundation
import CoreData


class AASWeatherData: NSManagedObject {
    override var debugDescription: String {
        let debugString = "\(location!) \(month)/\(year): Temp:\(minTemp)-\(maxTemp) rainInMM:\(rainInMM)"
        return debugString
    }
    class func data(managedObjectContext : NSManagedObjectContext,location: String, year: Int, month: Int, maxTemp : Float, minTemp : Float, airFrost : Int?, rainInMM : Float?, sunHours : String?) -> AASWeatherData? {
        let context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        context.parentContext = managedObjectContext
   
        guard let weather = NSEntityDescription.insertNewObjectForEntityForName(String(self), inManagedObjectContext: context) as? AASWeatherData else {
            return nil
        }
        weather.location = location
        weather.year = Int32(year)
        weather.month = Int16(month)
        weather.maxTemp = maxTemp
        weather.minTemp = minTemp
        if let airFrost = airFrost {
            weather.airFrost = Int16(airFrost)
        }
        if let rainInMM = rainInMM {
            weather.rainInMM = rainInMM
        }
        if let sunHours = sunHours {
            weather.sunHours = sunHours
        }
        do {
            try context.save()
        }
        catch {
            context.reset()
            return nil
        }
        var newWeather : AASWeatherData?
        managedObjectContext .performBlockAndWait { 
            newWeather = managedObjectContext.objectWithID(weather.objectID) as? AASWeatherData
        }
        return newWeather
    
    }

}
