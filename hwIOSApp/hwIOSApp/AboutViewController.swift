//
//  HydrantMapViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class AboutViewController : UIViewController
{
    var CancelButton: UIBarButtonItem!;
    var NavBar: UINavigationBar!;
    var AboutBox: UITextView!;
    var Logout: UIButton!;
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        
        CancelButton = UIFormatHelper.CreateNavBarButton("Cancel", targetView: self, buttonAction: Selector("CancelSent:"));
        NavBar = UIFormatHelper.CreateNavBar("About HydrantWiki", leftButton: CancelButton, rightButton: nil);
        view.addSubview(NavBar);
        
        let height:Float = UIFormatHelper.GetScreenHeight();
        let width:Float = UIFormatHelper.GetScreenWidth();
        
        //Add TextView
        let aboutFrame = CGRect(
            x: 0,
            y: 0,
            width: Double(UIFormatHelper.GetScreenWidth() - 16),
            height: Double(height - 150)
        );
        
        AboutBox = UITextView(frame: aboutFrame);
        AboutBox.text = UITextConstants.AboutBoxText;
        AboutBox.frame.origin.x = 8;
        AboutBox.frame.origin.y = 58;
        view.addSubview(AboutBox);
        
        let logoutFrame = CGRect(
            x: Double(10),
            y: Double(height - 75),
            width: Double(width - 20),
            height: Double(60)
        );
        
        Logout = UIButton(frame: logoutFrame);
        Logout.setTitle("Logout", forState: UIControlState.Normal);
        Logout.addTarget(self, action: "LogoutClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(Logout);
        
        // Do any additional setup after loading the view, typically from a nib.
        UIFormatHelper.Format(NavBar)
        UIFormatHelper.Format(CancelButton)
        UIFormatHelper.Format(AboutBox);
        UIFormatHelper.Format(Logout);
    }
    
    func CancelSent(sender: UIBarButtonItem)
    {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil);
    }
    
    func LogoutClicked(sender:UIButton)
    {
        let defaults = NSUserDefaults.standardUserDefaults();
        defaults.setObject(nil, forKey: "username");
        defaults.setObject(nil, forKey: "authToken");
        defaults.setObject(nil, forKey: "displayName");
        
        self.performSegueWithIdentifier("ReturnToLogin", sender: nil);
    }
}