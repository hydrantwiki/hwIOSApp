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
    var allowed:Bool = false
    public var locationAverage:LocationAverage;
    var completionHandlers:[(Location?)->Void] = []
    
    override init(){
        locationManager = CLLocationManager()
        
    
        quantityToCollect = 10
        periodBetween = 1
        warmUpPeriod = 1
        cancelCollecting = false;
        locationAverage = LocationAverage()
        alreadyRequested = false
    }
    
    public func Start(completion: (Location?) ->Void)
    {
        completionHandlers.append(completion)
        
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        if (CLLocationManager.authorizationStatus() == .NotDetermined)
        {
            locationManager.requestWhenInUseAuthorization()
        }
        else if (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse)
        {
            allowed = true;
        }
        
        if (allowed)
        {
            locationManager.requestLocation()
        }
    }


    
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.Authorized
            || status == CLAuthorizationStatus.AuthorizedAlways
            || status == CLAuthorizationStatus.AuthorizedWhenInUse)
        {
            allowed = true;
        }
        else
        {
            allowed = false;
        }
    }
    
    
    
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            locationAverage.add(location.coordinate.latitude, longitude: location.coordinate.longitude, elevation: location.altitude)
            QuantityCollected += 1
            
            if (QuantityCollected < quantityToCollect)
            {
                locationManager.requestLocation()
            }
            else
            {
                if (completionHandlers.count>0)
                {
                    locationManager.stopUpdatingLocation()
                    completionHandlers[0](locationAverage.getAverage())
                }
            }
        }
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Failed to find user's location: \(error.localizedDescription)")
        
        locationManager.requestLocation()
    }
    

    
}