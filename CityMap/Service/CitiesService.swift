//
//  CitiesService.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/24/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import CoreData

final class CitiesService {
    
    // MARK: - Properties
    
    static let shared = CitiesService()
    private init() {}
    
    private let networkManager = NetworkManager.shared
    private let coreDataManager = CoreDataManager.shared
    
    // Load cities.
    
    func cities(callback: @escaping ([City]) -> Void) {
        
        // Load cities from JSON.
        networkManager.getCities { [weak self] (remoteCities, error) in
            if let _ = error {
                // Fetch cities from entities of context.
                self?.fetchLocalCities(callback: callback)
                return
            }
            // Save cities from Network Manager.
            self?.storeRemoteCities(using: remoteCities, callback: callback)
        }
    }
    
    // Fetch cities from city entities.
    
    private func fetchLocalCities(callback: @escaping ([City]) -> Void) {
        let context = coreDataManager.context
        
        // Perform inside context.
        context.perform { [weak self] in
           
            // Fetch entities from context or return empty array.
            let cityEntities = self?.fetchCityEntities(from: context) ?? []
            
            // Array of cities which store city entities.
            var cities = [City?]()
            
            // Append City from City Entity (CityData)
            for cityEntity in cityEntities {
                cities.append(cityEntity.map())
            }
            
            // Store non-nil cities.
            callback(cities.compactMap({ $0 }))
        }
    }
    
    // Save and update cities in context and store them.
    
    private func storeRemoteCities(using cities: [City], callback: @escaping ([City]) -> Void) {
        let context = coreDataManager.context
        
        // Perform inside context.
        context.perform { [weak self] in
            
            // Fetch entities from context or return empry array.
            let cityEntities = self?.fetchCityEntities(from: context) ?? []
            
            // Delete every entity when func is started.
            for cityEntity in cityEntities {
                context.delete(cityEntity)
            }
            
            // Create city in context.
            for city in cities {
                _ = CityData.create(from: city, in: context)
            }
            
            // Update managed objects in context.
            try? context.save()
            
            // Store cities in block.
            callback(cities)
        }
    }
    
    // Return entities (array of CityData) from ManagedObjectContext.
    
    private func fetchCityEntities(from context: NSManagedObjectContext) -> [CityData] {
        let fetchRequest = NSFetchRequest<CityData>(entityName: "CityData")
        return (try? context.fetch(fetchRequest)) ?? []
    }
    
}
