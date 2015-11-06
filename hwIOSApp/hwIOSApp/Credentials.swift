//
//  Credentials.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/5/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation

public class Credentials {
    private static var credentials:Credentials = Credentials()
    
    private init(){
        
    }
    
    public static func GetInstance()->Credentials {
        return credentials;
    }
    
    public var userName:String?
    public var userToken:String?
}