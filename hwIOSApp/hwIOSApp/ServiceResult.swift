//
//  LoginResult.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/12/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import ObjectMapper

public class ServiceResult<T:Mappable> {
    init () {
        Result = nil;
        Payload = nil;
    }
    
    var Result:String?
    var Payload:T?
    
}