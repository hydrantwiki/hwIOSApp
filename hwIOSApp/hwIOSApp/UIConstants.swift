//
//  UIConstants.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/30/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import MapKit;

struct UIConstants {
    static let ButtonCornerRadius:Int = 10;
    static let ButtonBackgroundColor:UIColor = UIColor(red:176, green:196, blue:222)
    static let ButtonTextColor:UIColor = UIColor.whiteColor();
    static let ButtonTextDisabledColor:UIColor = UIColor.grayColor();
    
    static let HydrantWikiRed = UIColor(red:214, green:50, blue:0);
    static let HydrantWikiGray = UIColor(red:170, green:162, blue:154)
    static let HydrantWikiWhite = UIColor.whiteColor();
    
    static let ImageQuality = 0.5;
}


class UIFormatHelper {
    
    static func Format(control:UIButton)
    {
        control.backgroundColor = UIConstants.HydrantWikiGray
        control.setTitleColor( UIConstants.HydrantWikiRed, forState: UIControlState.Normal)
        control.setTitleColor( UIConstants.HydrantWikiWhite, forState: UIControlState.Disabled)
        control.layer.cornerRadius = 10
        control.clipsToBounds = true
    }
    
    static func Format(control:UIBarButtonItem)
    {
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIConstants.HydrantWikiRed
        control.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        
        var attributes2 = [String:AnyObject]()
        attributes2[NSForegroundColorAttributeName] = UIConstants.HydrantWikiWhite
        control.setTitleTextAttributes(attributes2, forState: UIControlState.Disabled)
    }
    
    static func Format(control:UIBarButtonItem, image:String)
    {
        var attributes = [String:AnyObject]()
        
        attributes[NSForegroundColorAttributeName] = UIConstants.HydrantWikiRed
        
        control.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
    }
    
    static func Format(control:UILabel)
    {
        control.backgroundColor = UIConstants.HydrantWikiWhite
    }
    
    static func Format(control:UINavigationBar)
    {
        control.backgroundColor = UIConstants.HydrantWikiGray
    }
    
    static func Format(control:UIToolbar)
    {
        control.backgroundColor = UIConstants.HydrantWikiGray
    }
    
    static func Format(control:UITableView)
    {
        
    }
    
    static func Format(control:MKMapView)
    {
        
    }
    
    static func Format(control:UITextField)
    {
        control.backgroundColor = UIConstants.HydrantWikiWhite
        
    }
}



extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

