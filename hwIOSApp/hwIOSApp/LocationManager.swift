//
//  LocationAverager.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/23/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import CoreLocation

public class LocationManager: NSObject, CLLocationManagerDelegate
{
    var cancelCollecting:Bool
    var locationManager : CLLocationManager
    var periodBetween : Double
    var warmUpPeriod : Int
    var alreadyRequested:Bool
    var allowed:Bool = false;
    var stopped:Bool = false;
    public var locationUpdated:ILocationUpdated? = nil
    public var OnlyOnce:Bool = false;
    
    override init()
    {
        locationManager = CLLocationManager()
        
        periodBetween = 30;
        warmUpPeriod = 1;
        cancelCollecting = false;
        alreadyRequested = false;
    }
    
    public func Start()
    {
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
            locationManager.requestLocation();
        }
    }
    
    public func Stop()
    {
        stopped = true;
    }
    
    public func locationManager(
        manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.AuthorizedAlways
            || status == CLAuthorizationStatus.AuthorizedWhenInUse)
        {
            allowed = true;
        }
        else
        {
            allowed = false;
        }
    }
    
    public func locationManager(
        manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation])
    {
        if (!stopped)
        {
            if let location = locations.first {
                
                if (locationUpdated != nil)
                {
                    locationUpdated!.NewLocation(
                        1,
                        latitude:location.coordinate.latitude,
                        longitude:location.coordinate.longitude,
                        elevation:location.altitude,
                        accuracy:location.horizontalAccuracy)
                }

                locationManager.stopUpdatingLocation();

                if (OnlyOnce)
                {
                    stopped = true;
                }
                
                if (!stopped)
                {
                    NSTimer.scheduledTimerWithTimeInterval(
                        periodBetween,
                        target: self,
                        selector: "RequestLocation",
                        userInfo: nil,
                        repeats: false);
                }
            }
        }
    }
    
    public func RequestLocation()
    {
        if (!stopped)
        {
            locationManager.requestLocation();
        }
    }
    
    public func locationManager(
        manager: CLLocationManager,
        didFailWithError error: NSError)
    {
        print("Failed to find user's location: \(error.localizedDescription)")
        
        locationManager.requestLocation()
    }
}