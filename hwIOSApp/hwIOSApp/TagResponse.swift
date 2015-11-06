//
//  TagResponse.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/5/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct TagResponseDTO : Mappable {
    var Success:Bool = false
    
    init?(_ map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        Success           <- map["Success"]
    }
}