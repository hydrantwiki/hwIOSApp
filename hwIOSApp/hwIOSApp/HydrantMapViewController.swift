//
//  HydrantMapViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit
import MapKit

public class HydrantMapViewController : UIViewController {
    
    public var user:User?;
    
    @IBOutlet var NavBar: UINavigationBar!
    @IBOutlet var OutsideStackView: UIStackView!
    @IBOutlet var MapStackView: UIStackView!
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var HydrantMap: MKMapView!
    @IBOutlet var TableViewButton: UIBarButtonItem!
    
    
    @IBAction func CancelSent(sender: AnyObject) {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
        
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        UIFormatHelper.Format(NavBar!);
        UIFormatHelper.Format(CancelButton);
        UIFormatHelper.Format(TableViewButton);
        
        UIFormatHelper.Format(HydrantMap)
    }
    
    @IBAction func TableViewButtonPressed(sender: AnyObject) {
    
    }
    
    
}