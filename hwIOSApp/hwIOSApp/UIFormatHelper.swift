//
//  UIFormatHelper.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 3/5/16.
//  Copyright © 2016 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit
import MapKit

public class UIFormatHelper {
    
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
        
        var attributes2 = [String:AnyObject]()
        attributes2[NSForegroundColorAttributeName] = UIConstants.HydrantWikiWhite
        control.setTitleTextAttributes(attributes2, forState: UIControlState.Disabled)
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