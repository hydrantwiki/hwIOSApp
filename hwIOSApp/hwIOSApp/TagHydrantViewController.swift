//
//  TagHydrantViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class TagHydrantViewController : UIViewController, ILocationUpdated {
    
    public var user:User?;
    
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var TakePhotoButton: UIButton!
    @IBOutlet weak var LatitudeLabel: UILabel!
    @IBOutlet weak var LongitudeLabel: UILabel!
    @IBOutlet weak var AccuracyLabel: UILabel!
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var HydrantImage: UIImageView!
    
    var locationManager:LocationManager?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = LocationManager()
        locationManager!.locationAverageUpdated = self
        
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager!.Start(){ (count:Int, location:Location?) in
            if (location != nil)
            {
                self.CountLabel.text = "Count: 10"
                self.LatitudeLabel.text = "Latitude: " + String(location!.latitude!)
                self.LongitudeLabel.text = "Longitude: " + String(location!.longitude!)
                self.AccuracyLabel.text = "Accuracy (m): " + String(location!.accuracy!)            }
        }
    }
    

    public func NewLocationAverage(
        count: Int,
        latitude: Double,
        longitude: Double,
        elevation: Double,
        accuracy: Double) {
        
            CountLabel.text = "Count: " + String(count)
            LatitudeLabel.text = "Latitude: " + String(latitude)
            LongitudeLabel.text = "Longitude: " + String(longitude)
            AccuracyLabel.text = "Accuracy (m): " + String(accuracy)
        
    }
    
    
    @IBAction func CancelSent(sender: AnyObject) {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
    }
}
