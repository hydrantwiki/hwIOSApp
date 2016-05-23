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

struct UIConstants
{
    static let ButtonCornerRadius:Int = 16;
    static let ButtonBackgroundColor:UIColor = UIColor(red:176, green:196, blue:222)
    static let ButtonTextColor:UIColor = UIColor.whiteColor();
    static let ButtonTextDisabledColor:UIColor = UIColor.grayColor();
    static let ButtonTextHeight:CGFloat = 36;
    
    static let HydrantWikiRed = UIColor(red:214, green:50, blue:0);
    static let HydrantWikiGray = UIColor(red:170, green:162, blue:154)
    static let HydrantWikiWhite = UIColor.whiteColor();
    
    static let ImageQuality = 0.5;
}

struct UITextConstants
{
    static let AboutBoxText = "HydrantWiki is an crowd source hydrant location database.\r\n \r\n" +
        "For more information on the system please see http://www.hydrantwiki.com.\r\n \r\n" +
        "Open Source Projects Used\r\n" +
        "- Alamofire\r\n" +
        "- ObjectMapper ";
}


extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        let newRed = CGFloat(red)/255;
        let newGreen = CGFloat(green)/255;
        let newBlue = CGFloat(blue)/255;
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0);
    }
}

