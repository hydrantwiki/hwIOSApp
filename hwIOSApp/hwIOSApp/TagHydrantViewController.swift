//
//  TagHydrantViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class TagHydrantViewController : UIViewController {
    
    public var user:User?;
    
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var TakePhotoButton: UIButton!
    @IBOutlet weak var LatitudeLabel: UILabel!
    @IBOutlet weak var LongitudeLabel: UILabel!
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var HydrantImage: UIImageView!
    
    var locationManager:LocationManager?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = LocationManager()
        
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager!.Start(){ (location:Location?) in
            if (location != nil)
            {
                self.LatitudeLabel.text = String(location!.latitude)
            }
        }
    }
    

    
    @IBAction func CancelSent(sender: AnyObject) {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
    }
}
