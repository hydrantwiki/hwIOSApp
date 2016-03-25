//
//  LocationAverager.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/23/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import CoreLocation

public class AveragingLocationManager: NSObject, CLLocationManagerDelegate
{
    public var QuantityCollected:Int = 0
    var cancelCollecting:Bool
    var locationManager : CLLocationManager
    var quantityToCollect : Int
    var periodBetween : Double
    var warmUpPeriod : Int
    var alreadyRequested:Bool
    var allowed:Bool = false
    var locationAverage:LocationAverage;
    var completionHandlers:[(Int, Location?)->Void] = []
    public var locationAverageUpdated:ILocationUpdated? = nil
    var completionFired:Bool = false;
    
    override init()
    {
        locationManager = CLLocationManager();
        
        quantityToCollect = 10;
        periodBetween = 1;
        warmUpPeriod = 1;
        cancelCollecting = false;
        locationAverage = LocationAverage();
        alreadyRequested = false;
    }
    
    public func Start(completion: (count:Int, location:Location?) ->Void)
    {
        completionHandlers.append(completion)
        
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
            NSTimer.scheduledTimerWithTimeInterval(
                0,
                target: self,
                selector: #selector(AveragingLocationManager.RequestLocation),
                userInfo: nil,
                repeats: false);
        }
    }
    
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
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
    
    public func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.first {
            
            locationAverage.add(location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                elevation: location.altitude,
                accuracy:location.horizontalAccuracy)

            QuantityCollected += 1
            
            if (QuantityCollected <= quantityToCollect)
            {
                if (locationAverageUpdated != nil)
                {
                    let currentAverage:Location? = locationAverage.getAverage();
                    
                    if (currentAverage != nil)
                    {
                        locationAverageUpdated!.NewLocation(
                            QuantityCollected,
                            latitude:currentAverage!.latitude!,
                            longitude:currentAverage!.longitude!,
                            elevation:currentAverage!.elevation!,
                            accuracy:currentAverage!.accuracy!);
                    }
                }
            }
            
            if (QuantityCollected < quantityToCollect)
            {
                NSTimer.scheduledTimerWithTimeInterval(
                    0,
                    target: self,
                    selector: #selector(AveragingLocationManager.RequestLocation),
                    userInfo: nil,
                    repeats: false);
            }
            else
            {
                if (completionHandlers.count>0)
                {
                    locationManager.stopUpdatingLocation();
                    
                    if (!completionFired)
                    {
                        completionFired = true;
                        completionHandlers[0](QuantityCollected, locationAverage.getAverage());
                    }
                }
            }
        }
    }
    
    public func RequestLocation()
    {
        NSThread.sleepForTimeInterval(0.5);
        locationManager.requestLocation();
    }
    
    public func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Failed to find user's location: \(error.localizedDescription)");
        locationManager.requestLocation();
    }
}