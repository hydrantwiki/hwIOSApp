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
    public var locationUpdated:ILocationUpdated? = nil;
    public var OnlyOnce:Bool = false;

    public static var LastLocation:Location!;
    
    override init()
    {
        locationManager = CLLocationManager();
        
        periodBetween = 10;
        warmUpPeriod = 1;
        cancelCollecting = false;
        alreadyRequested = false;
    }
    
    public func Start()
    {
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        
        if (CLLocationManager.authorizationStatus() == .NotDetermined)
        {
            locationManager.requestWhenInUseAuthorization();
        }
        else if (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse)
        {
            allowed = true;
        }
        
        if (allowed)
        {
            //locationManager.startMonitoringSignificantLocationChanges();
            
            NSTimer.scheduledTimerWithTimeInterval(
                0,
                target: self,
                selector: "RequestLocation",
                userInfo: nil,
                repeats: false);
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
            if let location = locations.first
            {
                let tempLocation = Location();
                tempLocation.accuracy = location.horizontalAccuracy;
                tempLocation.dateTime = NSDate();
                tempLocation.elevation = location.altitude;
                tempLocation.latitude = location.coordinate.latitude;
                tempLocation.longitude = location.coordinate.longitude;
                
                LocationCache.Instance.SetLocation(tempLocation);
                
                if (locationUpdated != nil)
                {
                    //TODO - Launch with timer
                    locationUpdated!.NewLocation(
                        1,
                        latitude:tempLocation.latitude!,
                        longitude:tempLocation.longitude!,
                        elevation:tempLocation.elevation!,
                        accuracy:tempLocation.accuracy!);
                }

                
                if (OnlyOnce)
                {
                    stopped = true;
                    locationManager.stopUpdatingLocation();
                }

//                if (!stopped)
//                {
//                    NSTimer.scheduledTimerWithTimeInterval(
//                        periodBetween,
//                        target: self,
//                        selector: "RequestLocation",
//                        userInfo: nil,
//                        repeats: false);
//                }
            }
        }
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
    }
    
    public func RequestLocation()
    {
        if (!stopped)
        {
            locationManager.requestLocation();
        }
    }    
}