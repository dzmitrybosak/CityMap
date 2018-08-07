//
//  City.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import Foundation

final class City {
    
    // MARK: - Properties
    
    let name: String
    let description: String
    
    // MARK: - Initialization
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    convenience init(description: String) {
        self.init(name: "", description: description)
    }
    
    convenience init(name: String) {
        self.init(name: name, description: "")
    }
    
    convenience init() {
        self.init(name: "")
    }
}
