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
        Alamofire.request(.GET,
            BaseUrl + "/api/hydrants/"
                + String(latitude) + "/"
                + String(longitude) + "/"
                + String(distance),
            parameters: [:],
            headers:GetAuthHeaders()
            )
            .responseString { response in
                if (response.result.value != nil)
                {
                    let json:String = response.result.value!
                    let result:HydrantQueryResponseDTO = Mapper<HydrantQueryResponseDTO>().map(json)!
                    
                    completion(response: result)
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