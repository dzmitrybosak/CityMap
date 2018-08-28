//
//  CityData+CoreDataClass.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/22/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//
//

import CoreData

@objc(CityData)
public class CityData: NSManagedObject {

    // Create City Entity from City in ManagedContext
    
    class func create(from city: City, in context: NSManagedObjectContext) -> CityData? {
        let cityEntity = NSEntityDescription.insertNewObject(forEntityName: String(describing: CityData.self), into: context) as? CityData
        cityEntity?.id = city.id
        cityEntity?.title = city.title
        cityEntity?.url = city.url.absoluteString
        cityEntity?.details = city.description
        cityEntity?.latitude = city.latitude
        cityEntity?.longitude = city.longitude
        return cityEntity
    }
    
    // Return City from entity CityData.
    
    func map() -> City? {
        return City(from: self)
    }
}

private extension City {
    
    // MARK: - Initialization
    
    init?(from entity: CityData) {
        guard let url = entity.url else {
            return nil
        }
        
        self.id = entity.id
        self.title = entity.title ?? ""
        self.url = URL(string: url)!
        self.description = entity.details ?? ""
        self.longitude = entity.longitude
        self.latitude = entity.latitude
    }
}
