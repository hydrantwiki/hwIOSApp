//
//  NearbyHydrantsViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class NearbyHydrantsViewController : UIViewController, ILocationUpdated {
    
    public var user:User?;
    var locationManager:LocationManager?
    
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var HydrantTableView: UITableView!
    @IBOutlet weak var MapViewButton: UIBarButtonItem!
    @IBOutlet weak var NavBar: UINavigationBar!
    
    
    @IBAction func CanceSent(sender: AnyObject) {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)        
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        locationManager = LocationManager()
        locationManager!.locationUpdated = self
        locationManager!.Start()
        
        UIFormatHelper.Format(NavBar)
        UIFormatHelper.Format(CancelButton)
        UIFormatHelper.Format(MapViewButton)
        UIFormatHelper.Format(HydrantTableView)
    }
    
    public func NewLocation(
        count: Int,
        latitude: Double,
        longitude: Double,
        elevation: Double,
        accuracy: Double) {
            
            
    }
    
    
}