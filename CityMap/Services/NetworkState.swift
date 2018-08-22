//
//  NetworkState.swift
//  CityMap
//
//  Created by Dzmitry Bosak on 8/17/18.
//  Copyright © 2018 Dzmitry Bosak. All rights reserved.
//

import Foundation
import Alamofire

class NetworkState {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
