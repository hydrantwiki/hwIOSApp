//
//  UIConstants.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/30/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

struct UIConstants {
    static let ButtonCornerRadius:Int = 10;
    static let ButtonBackgroundColor:UIColor = UIColor(red:176, green:196, blue:222)
    static let ButtonTextColor:UIColor = UIColor.whiteColor();
    static let ButtonTextDisabledColor:UIColor = UIColor.grayColor();
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