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
        
        let navFrame = CGRect(x: 0, y: 0, width: Int(UIFormatHelper.GetScreenWidth()), height: 50);
        
        //Setup the title bar
        NavBar = UINavigationBar(frame: navFrame);
        view.addSubview(NavBar);
        
        let navItem = UINavigationItem();
        navItem.title = "About HydrantWiki";
        
        CancelButton = UIBarButtonItem(
            title:"Cancel",
            style:UIBarButtonItemStyle.Plain,
            target:self,
            action:"CancelSent:");
        
        navItem.leftBarButtonItem = CancelButton;
        NavBar.setItems([navItem], animated: false);
        
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
        
        LayoutControls();
    }
    
    private func LayoutControls()
    {
        //NavBar.topAnchor.constraintEqualToAnchor(view.topAnchor).active=true;
        //NavBar.heightAnchor.constraintEqualToConstant(CGFloat(50)).active=true;
        //NavBar.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active=true;
        //NavBar.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active=true;
        //NavBar.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active=true;
        //NavBar.widthAnchor.constraintEqualToConstant(CGFloat(UIFormatHelper.GetScreenWidth())).active=true;
        
        //AboutBox.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 58).active=true;
        //AboutBox.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active=true;
//        AboutBox.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 8).active=true;
//        AboutBox.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: 8).active=true;
//        AboutBox.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: 8).active=true;
    }
    
    
    func CancelSent(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
    }
    
}