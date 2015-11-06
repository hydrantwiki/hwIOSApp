//
//  TagDTO.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/2/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct TagDTO : Mappable {
    var ImageGuid:String? = NSUUID().UUIDString
    var Position:PositionDTO?
    
    init() { }
    
    init?(_ map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        ImageGuid           <- map["ImageGuid"]
        Position            <- map["Position"]
    }
}