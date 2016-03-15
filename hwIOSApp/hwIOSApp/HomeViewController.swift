//
//  HomeViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class HomeViewController : UIViewController
{
    public var user:User?;
    @IBOutlet weak var TagHydrantButton: UIBarButtonItem!
    @IBOutlet weak var NearbyHydrantsButton: UIBarButtonItem!
    @IBOutlet weak var MapButton: UIBarButtonItem!
    @IBOutlet weak var AboutButton: UIBarButtonItem!
    @IBOutlet var NavBar: UINavigationBar!
    @IBOutlet var ToolBar: UIToolbar!
    @IBOutlet weak var MyHydrantCount: UILabel!
    
    @IBAction func TagHydrantSent(sender: AnyObject)
    {
        performSegueWithIdentifier("ShowTagHydrant", sender: nil)
    }
    
    @IBAction func NearbyHydrantsSent(sender: AnyObject)
    {
        performSegueWithIdentifier("ShowNearbyHydrants", sender: nil)
    }
    
    
    @IBAction func MapSent(sender: AnyObject)
    {
        performSegueWithIdentifier("ShowMap", sender: nil)
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        UIFormatHelper.Format(NavBar)
        UIFormatHelper.Format(ToolBar)
        
        //Top buttons
        UIFormatHelper.Format(AboutButton)
        
        //Bottom buttons
        UIFormatHelper.Format(TagHydrantButton, image:"")
        UIFormatHelper.Format(MapButton, image:"")
        UIFormatHelper.Format(NearbyHydrantsButton, image:"")
        
        //Other Controls
        UIFormatHelper.Format(MyHydrantCount);
                
        NSTimer.scheduledTimerWithTimeInterval(
            0.25,
            target: self,
            selector: "LoadCounts",
            userInfo: nil,
            repeats: false);
    }
    
    func LoadCounts()
    {
        let service = TagService()
        service.GetMyTagCount { (response) -> Void in
            
            if (response != nil
                && response!.Success)
            {
                let text:String = "Hydrants Tagged : " + String(response!.TagCount);
                self.MyHydrantCount.text = text;
            }
        }
    }
    
    @IBAction func AboutSent(sender: AnyObject)
    {
        performSegueWithIdentifier("ShowAbout", sender: nil)
    }
    
    @IBAction func returnToHome(sender: UIStoryboardSegue)
    {        
        
    }
}