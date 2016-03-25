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
    
    var warmUpPeriod : Int
    var alreadyRequested:Bool
    var allowed:Bool = false;
    var stopped:Bool = false;
    public var locationUpdated:ILocationUpdated? = nil;
    public var OnlyOnce:Bool = false;
    var Timer:NSTimer!;
    var NextLocationTime:NSDate = NSDate();

    public static var LastLocation:Location!;
    public var PeriodBetween : Double;
    public var ShortPeriodBetween : Double;
    
    override init()
    {
        locationManager = CLLocationManager();
        
        PeriodBetween = 30;
        ShortPeriodBetween = 5;
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
            
            Timer = NSTimer.scheduledTimerWithTimeInterval(
                1,
                target: self,
                selector: #selector(LocationManager.RequestLocation),
                userInfo: nil,
                repeats: true);
        }
    }
    
    public func Stop()
    {
        if (Timer != nil)
        {
            Timer.invalidate();
        }
        
        stopped = true;
        locationManager.stopUpdatingLocation();
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
            NextLocationTime = NSDate().addSeconds(Int(PeriodBetween));
            
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
            }
        }
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        NextLocationTime = NSDate().addSeconds(Int(ShortPeriodBetween));
    }
    
    public func RequestLocation()
    {
        let now:NSDate = NSDate();
        
        if (!stopped
            && now.isGreaterThanDate(NextLocationTime))
        {
            locationManager.requestLocation();
        }
    }    
}