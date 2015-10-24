//
//  LocationAverager.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/23/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationAverager {
    
    var cancelCollecting:Bool
    var locationManager : CLLocationManager
    var quantityToCollect : Int
    var periodBetween : Int
    var warmUpPeriod : Int
    
    init(){
        locationManager = CLLocationManager()
        
        quantityToCollect = 10
        periodBetween = 1
        warmUpPeriod = 1
        cancelCollecting = false;
    }
    
    
    public func Start(completion: (Location?) ->Void)
    {
        
    }
    
    
    
}