//
//  Cities.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/20/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import Foundation

struct Cities: Decodable {
    enum CodingKeys: String, CodingKey {
        case cities = "photos"
    }
    let cities: [City]
}
