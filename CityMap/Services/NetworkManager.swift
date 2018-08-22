//
//  CityService.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/7/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Properties
    
    var cities: [City] = []
    
    // Load URL, decode JSON and parse.
    
    func loadCities(completionHandler: (() -> Void)?) {
        
        // Set up the URL request
        let urlString = "https://api.myjson.com/bins/7ybe5"
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // Set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // Make the request
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let parsedResult = try decoder.decode(Cities.self, from: data)
                for city in parsedResult.cities {
                    let newCity = city
                    self.cities.append(newCity)
                }
            } catch {
                print("parse error")
            }
            completionHandler?()
        }
        task.resume()
    }
}
