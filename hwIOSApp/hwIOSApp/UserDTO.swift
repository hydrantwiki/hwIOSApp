//
//  UserDTO.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 12/5/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct UserDTO: Mappable {
    var AuthorizationToken:String?
    var DisplayName:String?
    var Username:String?
    
    init?(_ map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        AuthorizationToken  <- map["AuthorizationToken"]
        DisplayName         <- map["DisplayName"]
        Username            <- map["Username"]
    }
}