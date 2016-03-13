//
//  HydrantAnnotation.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 3/12/16.
//  Copyright © 2016 Brian Nelson. All rights reserved.
//

import Foundation
import MapKit

public class HydrantAnnotation: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D;
    
    // Title and subtitle for use by selection UI.
    public var title: String?;
    public var subtitle: String?;
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle;
        self.coordinate = coordinate
        
        super.init()
    }
}