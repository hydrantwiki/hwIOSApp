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
    
    static func Format(control:UITextView)
    {
        control.backgroundColor = UIConstants.HydrantWikiWhite;
        control.layer.borderColor = UIColor.blackColor().CGColor;
        control.layer.borderWidth = 1;
    }
    
    static func Format(control:UILabel)
    {
        control.backgroundColor = UIConstants.HydrantWikiWhite;
    }
    
    static func Format(control:UINavigationBar)
    {
        control.backgroundColor = UIConstants.HydrantWikiGray;
    }
    
    static func Format(control:UIToolbar)
    {
        control.backgroundColor = UIConstants.HydrantWikiGray;
    }
    
    static func Format(control:UITableView)
    {
        
    }
    
    static func Format(control:MKMapView)
    {
        
    }
    
    static func Format(control:UITextField)
    {
        control.backgroundColor = UIConstants.HydrantWikiWhite;
        
    }
    
    static func GetScreenWidth() -> Float
    {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width;
        
        return Float(screenWidth);
    }
    
    static func GetScreenHeight() -> Float
    {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height;
        
        return Float(screenHeight);
    }
    
    static func CreateNavBarButton(
        buttonTitle:String,
        targetView:UIViewController,
        buttonAction:Selector) -> UIBarButtonItem
    {
        let button = UIBarButtonItem(
            title:buttonTitle,
            style:UIBarButtonItemStyle.Plain,
            target:targetView,
            action:buttonAction);
        
        return button;
    }
    
    static func CreateNavBar(barTitle:String, leftButton:UIBarButtonItem?, rightButton:UIBarButtonItem?) -> UINavigationBar
    {
        let navFrame = CGRect(x: 0, y: 0, width: Int(UIFormatHelper.GetScreenWidth()), height: 50);
        
        //Setup the title bar
        let NavBar = UINavigationBar(frame: navFrame);
        
        let navItem = UINavigationItem();
        navItem.title = barTitle;
        
        if (leftButton != nil)
        {
            navItem.leftBarButtonItem = leftButton;
        }
        
        if (rightButton != nil)
        {
            navItem.rightBarButtonItem = rightButton;
        }
                
        NavBar.setItems([navItem], animated: false);
        
        return NavBar;
    }
    
}