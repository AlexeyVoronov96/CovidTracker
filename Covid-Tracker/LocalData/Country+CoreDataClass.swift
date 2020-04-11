//
//  Country+CoreDataClass.swift
//  Covid-Tracker
//
//  Created by Алексей Воронов on 11.04.2020.
//  Copyright © 2020 Алексей Воронов. All rights reserved.
//
//

import Foundation
import CoreData

public class Country: NSManagedObject {

    class func create(country: CovidCountryModel) {
        let localCountry = Country(context: CoreDataManager.shared.managedObjectContext)
        
        localCountry.id = Int16(country.id)
        localCountry.name = country.name
        localCountry.confirmed = Int64(country.confirmed)
        localCountry.deaths = Int64(country.deaths)
        localCountry.recovered = Int64(country.recovered)
        localCountry.active = Int64(country.active)
    }
    
    func update(country: CovidCountryModel) {
        id = Int16(country.id)
        name = country.name
        confirmed = Int64(country.confirmed)
        deaths = Int64(country.deaths)
        recovered = Int64(country.recovered)
        active = Int64(country.active)
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var confirmed: Int64
    @NSManaged public var recovered: Int64
    @NSManaged public var deaths: Int64
    @NSManaged public var active: Int64
}
