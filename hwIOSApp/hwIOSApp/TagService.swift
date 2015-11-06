//
//  TagService.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class TagService : BaseService {
    
    internal func SaveTag(tag:TagDTO, completion: (response:TagResponseDTO?) ->Void)
    {
        
        let headers : [String:String] = [ "Username":self.Username!, "AuthorizationToken":self.Token! ]
        let json = Mapper().toJSONString(tag, prettyPrint: false)
        
        Alamofire.request(.POST, BaseUrl + "/api/tag", parameters: [:], headers:headers, encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            mutableRequest.HTTPBody = json!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            return (mutableRequest, nil)
        })).responseString { response in
            let json:String = response.result.value!
            let result:TagResponseDTO = Mapper<TagResponseDTO>().map(json)!
            
            completion(response: result)
            
        }

    }
}