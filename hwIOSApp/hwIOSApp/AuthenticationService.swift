//
//  AuthenticationService.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class AuthenticationService : BaseService {

    internal func login(username:String, password:String, completion: (User?) ->Void)
    {
    
        var headers : [String:String] = [ "Username":username, "Password":password ]
        var parameters : [String:String]? = nil
        
        Alamofire.request(.POST, BaseUrl + "/api/authorize",
            parameters: parameters,
            headers:headers)
            .responseString { response in
                let json:String = response.result.value!
                let result:AuthenticationDTO = Mapper<AuthenticationDTO>().map(json)!
                
                if (result.Result=="Success")
                {
                    var user:User = User()
                    user.AuthToken = result.AuthorizationToken
                    user.Username = result.UserName
                    user.DisplayName = result.DisplayName
                    
                    completion(user)
                }
                else
                {
                    completion(nil)
                }
            }
    }
}