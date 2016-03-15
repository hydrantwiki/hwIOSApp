//
//  TagQueryResponse.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/16/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct HydrantQueryResponseDTO : Mappable
{
    var Success:Bool = false;
    var Hydrants:[HydrantDTO]? = nil;
    
    init() { }
    
    init?(_ map: Map)
    {
        
    }
    
    mutating func mapping(map: Map)
    {
        Success           <- map["Success"]
        Hydrants          <- map["Hydrants"]
    }
}