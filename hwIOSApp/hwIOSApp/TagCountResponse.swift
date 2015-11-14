//
//  TagCountResponse.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/14/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct TagCountResponseDTO : Mappable {
    var Success:Bool = false
    var TagCount:Int = 0;
    
    init() { }
    
    init?(_ map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        Success            <- map["Success"]
        TagCount           <- map["TagCount"]
    }
}