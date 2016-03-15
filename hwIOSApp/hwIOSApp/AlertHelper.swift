//
//  AlertHelper.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 3/5/16.
//  Copyright © 2016 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class AlertHelper
{
    static func ShowOkAlert(title: String, message: String, controller:UIViewController)
    {
        let uiAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert);
        uiAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil));
        
        controller.presentViewController(uiAlert, animated: true, completion: nil);
    }    
}