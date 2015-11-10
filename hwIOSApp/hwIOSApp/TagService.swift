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
import UIKit

class TagService : BaseService {
    
    internal func SaveTag(tag:TagDTO,
        completion: (response:TagResponseDTO?) ->Void)
    {
        let headerArray : [String:String] = [ "Username":self.Username!, "AuthorizationToken":self.Token! ]
        let json = Mapper().toJSONString(tag, prettyPrint: false)
        
        Alamofire.request(.POST,
            BaseUrl + "/api/tag",
            parameters: [:],
            headers:headerArray,
            encoding: .Custom({ (convertible, params) in
                                let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
                                mutableRequest.HTTPBody = json!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                                return (mutableRequest, nil)
                             }))
            .responseString { response in
                              let json:String = response.result.value!
                              let result:TagResponseDTO = Mapper<TagResponseDTO>().map(json)!
            
                              completion(response: result)
            }
    }
    
    internal func SaveImage(fileLocation:String,
        fileName:String,
        completion: (response:TagResponseDTO?) ->Void)
    {
        let fileUrl = NSURL(fileURLWithPath: fileLocation)
        var headerArray = [String:String]();
        headerArray["Username"] = self.Username!;
        headerArray["AuthorizationToken"] = self.Token!;
        
//        Alamofire.upload(.POST,
//            BaseUrl + "/api/image/" + fileName,
//            headers:headerArray,
//            file: fileUrl)
//            .responseString { response in
//                var output:TagResponseDTO = TagResponseDTO()
//                
//                output.Message = response.result.value;
//                
//                            completion(response: output)
//        }
        
        Alamofire.upload(
            .POST,
            BaseUrl + "/api/image/",
            headers: headerArray,
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: fileUrl, name: fileName)
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        var output:TagResponseDTO = TagResponseDTO()
                        output.Success = true;
                        output.Message = "";
                        completion(response: output)
                    }
                case .Failure(let encodingError):
                    var output:TagResponseDTO = TagResponseDTO()
                    output.Success = false;
                    output.Message = "Failed to save image";
                    completion(response: output)
                }
            }
        )
        
    }
}