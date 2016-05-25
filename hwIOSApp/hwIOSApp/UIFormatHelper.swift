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

public class UIFormatHelper
{
    static func Format(control:UIButton)
    {
        control.backgroundColor = UIConstants.HydrantWikiGray;
        
        control.setTitleColor( UIConstants.ButtonTextColor, forState: UIControlState.Normal);
        control.setTitleColor( UIConstants.ButtonTextDisabledColor, forState: UIControlState.Disabled);

        control.titleLabel?.font = UIFont(name: UIConstants.ButtonFontName, size: UIConstants.ButtonTextHeight);
        
        control.layer.cornerRadius = 10;
        control.clipsToBounds = true;
    }
    
    static func Format(control:UIBarButtonItem)
    {
        var attributes = [String:AnyObject]();
        attributes[NSForegroundColorAttributeName] = UIConstants.HydrantWikiWhite;
        control.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        
        var attributes2 = [String:AnyObject]()
        attributes2[NSForegroundColorAttributeName] = UIConstants.HydrantWikiGray
        control.setTitleTextAttributes(attributes2, forState: UIControlState.Disabled)
    }
    
    static func Format(control:UIBarButtonItem, image:String)
    {
        var attributes = [String:AnyObject]()
        attributes[NSForegroundColorAttributeName] = UIConstants.HydrantWikiRed;
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
    
    static func GetFrame(
        x:Double,
        y:Double,
        width:Double,
        height:Double) -> CGRect
    {
        let rect = CGRect(
            x: x,
            y: y,
            width: width,
            height: height
        );
        
        return rect;
    }
    
    static func GetFrameTopWithMargin(
        top:Double,
        margin:Double) -> CGRect
    {
        let screenWidth:Double = GetScreenWidthAsDouble();
        let screenHeight:Double = GetScreenHeightAsDouble();
        let height:Double = screenHeight - (top + margin);
        let width:Double = screenWidth - 2 * margin;
       
        let rect = CGRect(
            x: margin,
            y: top,
            width: width,
            height: height
        );
        
        return rect;
    }
    
    static func GetFrameTopWithMarginMaxHeight(
        top:Double,
        margin:Double,
        maxHeightPercent:Double) -> CGRect
    {
        let screenWidth:Double = GetScreenWidthAsDouble();
        let screenHeight:Double = GetScreenHeightAsDouble();
        let width:Double = screenWidth - 2 * margin;

        var height:Double = screenHeight - (top + margin);
        let maxHeight:Double = screenHeight * maxHeightPercent;
        
        if (height > maxHeight)
        {
            height = maxHeight;
        }
        
        let rect = CGRect(
            x: margin,
            y: top,
            width: width,
            height: height
        );
        
        return rect;
    }
    
    static func GetFrameByPercent(
        xPercent:Double,
        yPercent:Double,
        widthPercent:Double,
        heightPercent:Double) -> CGRect
    {
        let width:Double = GetScreenWidthAsDouble();
        let height:Double = GetScreenHeightAsDouble();
        
        let rect = CGRect(
            x: width * xPercent,
            y: height * yPercent,
            width: width * widthPercent,
            height: height * heightPercent
        );
        
        return rect;
    }
    
    static func FormatAsHeader(control:UILabel)
    {
        control.font = UIFont(name: "Heiti TC", size: 60);
        control.backgroundColor = UIConstants.HydrantWikiWhite;
        control.textAlignment = NSTextAlignment.Center;
        control.baselineAdjustment = .AlignCenters;
        control.textColor = UIColor.blackColor();
        control.numberOfLines = 0;
        control.minimumScaleFactor = 0.2;
        control.adjustsFontSizeToFitWidth = true;
    }
    
    static func Format(control:UILabel)
    {
        control.backgroundColor = UIConstants.HydrantWikiWhite;
    }
    
    static func Format(control:UINavigationBar)
    {
        control.backgroundColor = UIConstants.HydrantWikiDarkGray;
    }
    
    static func Format(control:UIToolbar)
    {
        control.backgroundColor = UIConstants.HydrantWikiDarkGray;
    }
    
    static func Format(control:UITableView)
    {
        
    }
    
    static func Format(control:MKMapView)
    {
        
    }
    
    static func Format(control:UITextField)
    {
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, control.frame.height))
        control.leftView = paddingView
        control.leftViewMode = UITextFieldViewMode.Always
        
        control.backgroundColor = UIConstants.HydrantWikiWhite;
        control.layer.borderColor = UIColor.grayColor().CGColor;
        control.layer.borderWidth = 1;
        control.layer.cornerRadius = 5;
    }
    
    static func GetScreenWidthAsDouble() -> Double
    {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width;
        
        return Double(screenWidth);
    }
    
    static func GetScreenHeightAsDouble() -> Double
    {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height;
        
        return Double(screenHeight);
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