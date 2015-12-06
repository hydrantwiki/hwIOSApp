//
//  AuthenticationDTO.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/12/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct AuthenticationResponse: Mappable {
    var Success:Bool = false;
    var Available:Bool = false;
    
    init?(_ map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        Success           <- map["Success"]
        Available         <- map["Available"]
    }
}