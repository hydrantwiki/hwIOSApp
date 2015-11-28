//
//  ILocationUpdated.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/25/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation

public protocol ILocationUpdated
{
    func NewLocation(count:Int, latitude:Double, longitude:Double, elevation:Double, accuracy:Double)
}