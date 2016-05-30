//
//  AASWeatherData+CoreDataProperties.swift
//  AsynchronousCoreData
//
//  Created by Frank Saar on 29/05/2016.
//  Copyright © 2016 SAMedialabs. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AASWeatherData {

    @NSManaged var location: String?
    @NSManaged var year: Int32
    @NSManaged var month: Int16
    @NSManaged var maxTemp: Float
    @NSManaged var minTemp: Float
    @NSManaged var airFrost: Int16
    @NSManaged var rainInMM: Float
    @NSManaged var sunHours: String?

}
