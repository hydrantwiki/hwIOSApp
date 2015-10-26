//
//  LocationAverage.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/23/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation

public class LocationAverage {
    
    public var locations:[Location] = [Location]()
    
    public func add(location:Location)
    {
        locations.append(location)
    }
    
    public func add(latitude:Double, longitude:Double, elevation:Double, accuracy:Double)
    {
        if (latitude != 0.0
            && longitude != 0.0)
        {
            let location:Location = Location()
            location.latitude = latitude
            location.longitude = longitude
            location.dateTime = NSDate()
            location.elevation = elevation
            location.accuracy = accuracy
            
            add(location);
        }
    }
    
    public func getAverage() -> Location? {
        var count : Double = 0
        var latitude : Double = 0
        var longitude : Double = 0
        var elevation : Double = 0
        var accuracy : Double = 0
        
        for location in locations {
            if (location.latitude! != 0.0
                && location.longitude! != 0.0)
            {
                count += 1
                latitude += location.latitude!
                longitude += location.longitude!
                elevation += location.elevation!
                accuracy += location.accuracy!
            }
        }
        
        if count > 0
        {
            let output:Location = Location()
            output.dateTime = NSDate()
            output.latitude = latitude / count
            output.longitude = longitude / count
            output.elevation = elevation / count
            output.accuracy = accuracy / count
            
            return output
        }
        
        return nil;
    }
    
    
    
}