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
    
    internal func SaveTag(
        tag:TagDTO,
        completion: (response:TagResponseDTO?) ->Void)
    {
        let json = Mapper().toJSONString(tag, prettyPrint: false)
        
        Alamofire.request(.POST,
            BaseUrl + "/api/tag",
            parameters: [:],
            headers:GetAuthHeaders(),
            encoding: .Custom({ (convertible, params) in
                let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest;
                mutableRequest.HTTPBody = json!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false);
                return (mutableRequest, nil);
            }))
            .responseString { response in
                let json:String = response.result.value!;
                let result:TagResponseDTO = Mapper<TagResponseDTO>().map(json)!;
            
                completion(response: result);
            }
    }
    
    internal func SaveImage(
        fileLocation:String,
        fileName:String,
        completion: (response:TagResponseDTO?) ->Void)
    {
        let fileUrl = NSURL(fileURLWithPath: fileLocation)
        
        Alamofire.upload(
            .POST,
            BaseUrl + "/api/image/",
            headers: GetAuthHeaders(),
            multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(fileURL: fileUrl, name: fileName)
            },
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        var output:TagResponseDTO = TagResponseDTO();
                        output.Success = true;
                        output.Message = "";
                        completion(response: output);
                    }
                case .Failure(let encodingError):
                    var output:TagResponseDTO = TagResponseDTO();
                    output.Success = false;
                    output.Message = "Failed to save image";
                    completion(response: output);
                }
            }
        )
    }
    
    internal func GetMyTagCount(
        completion: (response:TagCountResponseDTO?) ->Void)
    {
        Alamofire.request(.GET,
            BaseUrl + "/api/tags/mine/count",
            parameters: [:],
            headers:GetAuthHeaders()
            )
            .responseString { response in
                if (response.result.value != nil)
                {
                    let json:String = response.result.value!;
                    
                    if (!json.hasPrefix("<!DOCTYPE"))
                    {
                        let result:TagCountResponseDTO = Mapper<TagCountResponseDTO>().map(json)!;
                        completion(response: result);
                    }
                    return;
                }

                var resultDefault:TagCountResponseDTO = TagCountResponseDTO();
                resultDefault.Success = false;
                resultDefault.TagCount = 0;
                completion(response: resultDefault);
        }
    }
}