//
//  Hydrant.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/16/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct HydrantDTO : Mappable
{    
    var HydrantGuid:String?
    var ThumbnailUrl:String?
    var ImageUrl:String?
    var DistanceInFeet:Double?
    var Position:PositionDTO?
    var Username:String?
    
    init?(_ map: Map)
    {
    
    }
    
    mutating func mapping(map: Map)
    {
        HydrantGuid             <- map["HydrantGuid"]
        ThumbnailUrl            <- map["ThumbnailUrl"]
        ImageUrl                <- map["ImageUrl"]
        DistanceInFeet          <- map["DistanceInFeet"]
        Position                <- map["Position"]
        Username                <- map["Username"]
    }
}