//
//  DoubleHelper.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 3/13/16.
//  Copyright © 2016 Brian Nelson. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}