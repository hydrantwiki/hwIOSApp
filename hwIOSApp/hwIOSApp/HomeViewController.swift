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
    @IBOutlet weak var TagHydrantButton: UIBarButtonItem!
    @IBOutlet weak var NearbyHydrantsButton: UIBarButtonItem!
    @IBOutlet weak var MapButton: UIBarButtonItem!
    @IBOutlet weak var AboutButton: UIBarButtonItem!
    
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
    @IBAction func AboutSent(sender: AnyObject) {
        performSegueWithIdentifier("ShowAbout", sender: nil)
    }
    
    @IBAction func returnToHome(sender: UIStoryboardSegue) {
        
        
    }
}