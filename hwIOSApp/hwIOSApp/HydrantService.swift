//
//  HydrantService.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import UIKit

internal class HydrantService : BaseService {
    
    internal func GetNearbyHydrants(
        latitude:Double,
        longitude:Double,
        distance:Double,
        completion: (response:HydrantQueryResponseDTO?) ->Void)
    {
        let uri = BaseUrl + "/api/hydrants/"
            + String(latitude) + "/"
            + String(longitude) + "/"
            + String(distance);
        
        Alamofire.request(.GET,
            uri,
            parameters: [:],
            headers:GetAuthHeaders()
            )
            .responseString { response in
                if (response.result.isSuccess
                    && response.result.value != nil
                    && response.result.error == nil)
                {
                    let json:String = response.result.value!;
                    
                    if (!json.hasPrefix("<!DOCTYPE"))
                    {
                        let result:HydrantQueryResponseDTO = Mapper<HydrantQueryResponseDTO>().map(json)!
                        completion(response: result)
                        
                        return;
                    }
                }
                
                var result:HydrantQueryResponseDTO = HydrantQueryResponseDTO()
                result.Success = false;
                result.Hydrants = nil;
                completion(response: result)
        }
    }
    
    
    internal func GetHydrantsInBox(
        minLatitude:Double,
        maxLatitude:Double,
        minLongitude:Double,
        maxLongitude:Double,
        completion: (response:HydrantQueryResponseDTO?) ->Void)
    {
        let url:String = BaseUrl + "/api/hydrants/"
            + String(maxLongitude) + "/"
            + String(minLongitude) + "/"
            + String(maxLatitude) + "/"
            + String(minLatitude)
        
        Alamofire.request(.GET, url,
            parameters: [:],
            headers:GetAuthHeaders()
            )
            .responseString { response in
                if (response.result.value != nil)
                {
                    do {
                        let json:String = response.result.value!
                        let result:HydrantQueryResponseDTO = Mapper<HydrantQueryResponseDTO>().map(json)!
                        
                        completion(response: result)
                    } catch _ {
                        var result:HydrantQueryResponseDTO = HydrantQueryResponseDTO()
                        result.Success = false;
                        result.Hydrants = nil;
                        
                        completion(response: result)
                    }
                }
                else
                {
                    var result:HydrantQueryResponseDTO = HydrantQueryResponseDTO()
                    result.Success = false;
                    result.Hydrants = nil;
                    
                    completion(response: result)
                }
        }
        
    }

}