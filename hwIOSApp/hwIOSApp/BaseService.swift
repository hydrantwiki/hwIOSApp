//
//  AbstractService.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import Alamofire

class BaseService
{
    //var BaseUrl = "http://app.hydrantwiki.com"
    var BaseUrl:String;
    var credentials:Credentials
    
    init()
    {
        credentials = Credentials.GetInstance()
        
        let infoPlist = NSBundle.mainBundle().infoDictionary;
        BaseUrl = infoPlist!["HWAppURL"] as! String;
    }

    func GetAlamofireManager(timeout:Double) -> Alamofire.Manager
    {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForResource = timeout;
        
        return Alamofire.Manager(configuration: configuration);
    }
    
    var Username:String?
    {
        get
        {
            return credentials.userName;
        }
        
        set(username)
        {
            credentials.userName = username;
        }
    }
    
    var Token:String?
    {
        get
        {
            return credentials.userToken;
        }
        
        set(token)
        {
            credentials.userToken = token;
        }
    }
    
    func GetAuthHeaders() -> [String:String]
    {
        let headerArray : [String:String] = [ "Username":self.Username!, "AuthorizationToken":self.Token! ];
        
        return headerArray;
    }
}