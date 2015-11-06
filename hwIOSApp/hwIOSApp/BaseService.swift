//
//  AbstractService.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation

class BaseService {
    //var BaseUrl = "http://app.hydrantwiki.com"
    var BaseUrl = "http://192.168.50.6"

    
    var credentials:Credentials
    
    init()
    {
        credentials = Credentials.GetInstance()
    }
    
    var Username:String? {
        get {
            return credentials.userName;
        }
        
        set(username) {
            credentials.userName = username;
        }
    }
    
    var Token:String? {
        get {
            return credentials.userToken;
        }
        
        set(token) {
            credentials.userToken = token;
        }
    }
    
    
}