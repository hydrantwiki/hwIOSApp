//
//  LocationCache.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 3/17/16.
//  Copyright © 2016 Brian Nelson. All rights reserved.
//

import Foundation

public class LocationCache
{
    private init () { }
    public static let Instance:LocationCache = LocationCache();
    
    public private(set) var LastLocation:Location? = nil;
    
    public func SetLocation(lastLocation:Location)
    {
        LastLocation = lastLocation;
    }
}