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
        var manager = GetAlamofireManager(5);
        
        Alamofire.request(.POST, BaseUrl + "/api/authorize",
            parameters: parameters,
            headers:headers)
            .responseString { response in
                if (response.result.isSuccess
                    && response.result.value != nil)
                {
                    let json:String = response.result.value!
                    let result:AuthenticationResponse = Mapper<AuthenticationResponse>().map(json)!
                    
                    if (result.Success)
                    {
                        var resultUser = result.User;
                        
                        if (resultUser != nil)
                        {
                            var user:User = User();
                            user.AuthToken = resultUser!.AuthorizationToken
                            user.Username = resultUser!.Username
                            user.DisplayName = resultUser!.DisplayName
                            completion(user);
                            
                            return;
                        }
                    }
                    
                    
                }
                
                completion(nil);
            }
    }
}