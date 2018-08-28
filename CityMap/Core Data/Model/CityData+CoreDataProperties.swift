//
//  CityData+CoreDataProperties.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/22/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//
//

import CoreData

extension CityData {
    
    // MARK: - Properties
    
    @NSManaged public var id: Int
    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var url: String?
}
