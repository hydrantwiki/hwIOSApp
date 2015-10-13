//
//  AuthenticationDTO.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/12/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct AuthenticationDTO: Mappable {
    var Result:String?
    var AuthorizationToken:String?
    var DisplayName:String?
    var UserName:String?
    
    init?(_ map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        Result              <- map["Result"]
        AuthorizationToken  <- map["AuthorizationToken"]
        DisplayName         <- map["DisplayName"]
        UserName            <- map["UserName"]
    }
}