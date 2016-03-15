//
//  AvailableResponse.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 12/5/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

struct AuthenticationResponse: Mappable
{
    var User:UserDTO?
    var Success:Bool = false;
    var Message:String?
    
    init?(_ map: Map)
    {
        
    }
    
    mutating func mapping(map: Map)
    {
        User            <- map["User"];
        Success         <- map["Success"];
        Message         <- map["Message"];
    }
}