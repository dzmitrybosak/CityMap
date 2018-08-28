//
//  CityService.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/7/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import Foundation

// MARK: - Constants

private enum Constants {
    static let url = "https://api.myjson.com/bins/7ybe5"
}

// Type alias with parameters: array of cities and optional error (if it will be).
typealias CitiesCallBack = (_ cities: [City], _ error: Error?) -> Void

final class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    private init() {}
    
    // Set up the URL Session
    private let session = URLSession.shared
    
    // Set up JSON Decoder
    private let decoder = JSONDecoder()
    
    // Load URL, decode JSON and parse.
    // This method takes closure CitiesCallBack.
    func getCities(callBack: @escaping CitiesCallBack) {
        
        // Setup URL
        // If url is wrong, empty array and empty error will return.
        guard let url = URL(string: Constants.url) else {
            callBack([], nil)
            return
        }
        
        // Setup URL Request
        let urlRequest = URLRequest(url: url)
        
        // Load data from JSON and parse it
        let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            
            // Сonverting a weak reference to a strong reference for ARM.
            guard let strongSelf = self else {
                callBack([], nil)
                return
            }
            
            // Return error if error will be error.
            if let error = error {
                callBack([], error)
                return
            }
            
            // Return empry array and ampty error if data will be data.
            guard let data = data else {
                callBack([], nil)
                return
            }
            
            do {
                let parsedResult = try strongSelf.decoder.decode(Cities.self, from: data)
                
                // Return loaded cities and empty error.
                callBack(parsedResult.cities, nil)
                
            } catch (let error) {
                print("Can't decode cities. Error: \(error)")
                
                // Return empty array and error.
                callBack([], error)
            }   
        }
        task.resume()
    }
}
