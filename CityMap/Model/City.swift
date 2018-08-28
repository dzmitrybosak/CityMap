//
//  City.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/6/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import Foundation

struct City: Decodable {
    
    // MARK: - Properties
    
    var id: Int
    var title: String
    var description: String
    var latitude: Double
    var longitude: Double
    var url: URL
    
    // MARK: - Coding Keys
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case description
        case latitude
        case longitude
        case url
    }
    
    // MARK: - Initialization
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.url = try container.decode(URL.self, forKey: .url)
    }
}
