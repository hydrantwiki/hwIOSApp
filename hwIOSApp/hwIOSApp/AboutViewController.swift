//
//  HydrantMapViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class AboutViewController : UIViewController {
    
    public var user:User?;
    
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var NavBar: UINavigationBar!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIFormatHelper.Format(NavBar)
        
        UIFormatHelper.Format(CancelButton)
        
    }
    
    @IBAction func CancelSent(sender: AnyObject) {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
    }
    
}