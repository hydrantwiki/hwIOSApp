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
    var CancelButton: UIBarButtonItem!;
    var NavBar: UINavigationBar!;
    var AboutBox: UITextView!;
    
    override public func viewDidLoad() {
        super.viewDidLoad();
        
        CancelButton = UIFormatHelper.CreateNavBarButton("Cancel", targetView: self, buttonAction: Selector("CancelSent:"));
        NavBar = UIFormatHelper.CreateNavBar("About HydrantWiki", leftButton: CancelButton, rightButton: nil);
        view.addSubview(NavBar);
        
        //Add TextView
        let aboutFrame = CGRect(
            x: 0,
            y: 0,
            width: Int(UIFormatHelper.GetScreenWidth())-16,
            height: Int(UIFormatHelper.GetScreenHeight())-64);
        
        AboutBox = UITextView(frame: aboutFrame);
        AboutBox.text = UITextConstants.AboutBoxText;
        AboutBox.frame.origin.x = 8;
        AboutBox.frame.origin.y = 58;
        view.addSubview(AboutBox);
        
        // Do any additional setup after loading the view, typically from a nib.
        UIFormatHelper.Format(NavBar)
        UIFormatHelper.Format(CancelButton)
        UIFormatHelper.Format(AboutBox);        
    }
    
    
    func CancelSent(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
    }
    
}