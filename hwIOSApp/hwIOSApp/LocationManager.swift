//
//  LocationAverager.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/23/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationManager: NSObject, CLLocationManagerDelegate  {
    
    public var QuantityCollected:Int = 0
    var cancelCollecting:Bool
    var locationManager : CLLocationManager
    var quantityToCollect : Int
    var periodBetween : Double
    var warmUpPeriod : Int
    var alreadyRequested:Bool
    public var locationAverage:LocationAverage;
    
    override init(){
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        quantityToCollect = 10
        periodBetween = 1
        warmUpPeriod = 1
        cancelCollecting = false;
        locationAverage = LocationAverage()
        alreadyRequested = false
    }
    
    public func Start(completion: (Location?) ->Void)
    {
        alreadyRequested = false;
        while QuantityCollected <= quantityToCollect && !cancelCollecting{
            
            if (!alreadyRequested)
            {
                locationManager.requestLocation()
                alreadyRequested = true
            }
                
            //NSThread.sleepForTimeInterval(periodBetween)
        }
        
        completion(locationAverage.getAverage())
    }
    
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationAverage.add(location.coordinate.latitude, longitude: location.coordinate.longitude, elevation: location.altitude)
            QuantityCollected += 1
            alreadyRequested = false;
        }
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
}