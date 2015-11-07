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
    var Altitude:Double?
    var Accuracy:Double?
    var DeviceDateTime:NSDate?
    var WasAveraged:Bool = false
    
    init?(_ map: Map){
        
    }
    
    init(location:Location, wasAveraged:Bool)
    {
        self.Latitude = location.latitude
        self.Longitude = location.longitude
        self.Altitude = location.elevation
        self.Accuracy = location.accuracy
        self.DeviceDateTime = NSDate()
        self.WasAveraged = wasAveraged;
    }
    
    mutating func mapping(map: Map) {
        Latitude            <- map["Latitude"]
        Longitude           <- map["Longitude"]
        Altitude            <- map["Altitude"]
        Accuracy            <- map["Accuracy"]
        WasAveraged         <- map["WasAveraged"]
        DeviceDateTime      <- (map["DeviceDateTime"], ISO8601DateTransform())
        
    }
}