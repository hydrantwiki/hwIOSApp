//
//  PositionDTO.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/2/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct PositionDTO : Mappable {
    var Latitude:Double?
    var Longitude:Double?
    var Accuracy:Double?
    var DeviceDateTime:NSDate?
    
    init?(_ map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        Latitude            <- map["Latitude"]
        Longitude           <- map["Longitude"]
        Accuracy            <- map["Accuracy"]
        DeviceDateTime      <- map["DeviceDateTime"]
    }
}