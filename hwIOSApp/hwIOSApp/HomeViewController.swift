//
//  HomeViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class HomeViewController : UIViewController {

    public var user:User?;
    
    @IBAction func TagHydrantSent(sender: AnyObject) {
        performSegueWithIdentifier("ShowTagHydrant", sender: nil)
    }
    
    @IBAction func NearbyHydrantsSent(sender: AnyObject) {
        performSegueWithIdentifier("ShowNearbyHydrants", sender: nil)
    }
    
    
    @IBAction func MapSent(sender: AnyObject) {
        performSegueWithIdentifier("ShowMap", sender: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }


}