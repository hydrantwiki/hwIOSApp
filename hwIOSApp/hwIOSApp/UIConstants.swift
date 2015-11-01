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

struct UIConstants {
    static let ButtonCornerRadius:Int = 10;
    static let ButtonBackgroundColor:UIColor = UIColor(red:176, green:196, blue:222)
    static let ButtonTextColor:UIColor = UIColor.whiteColor();
    static let ButtonTextDisabledColor:UIColor = UIColor.grayColor();
    
    static let HydrantWikiRed = UIColor(214, 50, 0);
    static let HydrantWikiGray = UIColor(170, 162, 154)
    static let HydrantWikiWhite = UIColor()
}


class UILayoutHelper {
    
    static func Format(control:UIButton)
    {
        control.backgroundColor = UIConstants.ButtonBackgroundColor
        control.setTitleColor( UIConstants.ButtonTextColor, forState: UIControlState.Normal)
        control.setTitleColor( UIConstants.ButtonTextDisabledColor, forState: UIControlState.Disabled)
        control.layer.cornerRadius = 10
        control.clipsToBounds = true
    }
    
    static func Format(control:UIBarButtonItem)
    {

    }
    
    static func Format(control:UINavigationBar)
    {
        
    }
    
    static func Format(control:UIToolbar)
    {
        control.backgroundColor = UIColor(
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

