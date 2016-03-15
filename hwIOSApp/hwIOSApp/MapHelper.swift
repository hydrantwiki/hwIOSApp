//
//  MapHelper.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 3/12/16.
//  Copyright © 2016 Brian Nelson. All rights reserved.
//

import Foundation
import MapKit

typealias Edges = (ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D);

extension MKMapView
{
    func edgePoints() -> Edges
    {
        let nePoint = CGPoint(x: self.bounds.maxX, y: self.bounds.origin.y);
        let swPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY);
        let neCoord = self.convertPoint(nePoint, toCoordinateFromView: self);
        let swCoord = self.convertPoint(swPoint, toCoordinateFromView: self);
        return (ne: neCoord, sw: swCoord);
    }
}