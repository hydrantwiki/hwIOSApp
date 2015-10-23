//
//  NearbyHydrantsViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class NearbyHydrantsViewController : UIViewController {
    
    public var user:User?;
    
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var HydrantTableView: UITableView!
    @IBOutlet weak var MapViewButton: UIBarButtonItem!
    @IBOutlet weak var NavBar: UINavigationBar!
    
    @IBAction func CanceSent(sender: AnyObject) {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
        
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
}