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
    var NavBar: UINavigationBar!
    var AboutButton: UIBarButtonItem!

    var TagHydrantButton: UIButton!
    var NearbyHydrantsButton: UIButton!
    var MapButton: UIButton!
    
    var MyHydrantCount: UILabel!
    var Timer:NSTimer!;
    
    
    override public func viewDidAppear(animated: Bool) {
        Timer = NSTimer.scheduledTimerWithTimeInterval(
            0.1,
            target: self,
            selector: #selector(HomeViewController.LoadCounts),
            userInfo: nil,
            repeats: false);
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        
        let height:Float = UIFormatHelper.GetScreenHeight();
        let width:Float = UIFormatHelper.GetScreenWidth();
        
        /* setup the Navbar */
        AboutButton = UIFormatHelper.CreateNavBarButton(
            "About",
            targetView: self,
            buttonAction: #selector(HomeViewController.AboutPressed(_:)));
        
        NavBar = UIFormatHelper.CreateNavBar("HydrantWiki", leftButton: nil, rightButton: AboutButton);
        view.addSubview(NavBar);
        
        let buttonHeight:Double = Double(height / 8.0);
        let firstButton:Double = 130;
        let buttonSpacing:Double = 30;
        
        /* Setup other controls */
        let countFrame = UIFormatHelper.GetFrameTopWithMarginMaxHeight(55.0, margin:10.0, maxHeightPercent:0.05);
        MyHydrantCount = UILabel(frame: countFrame);
        MyHydrantCount.text = "Hydrants Tagged : Loading...";
        view.addSubview(MyHydrantCount);
        
        /* Tag Hydrant */
        let tagHydrantFrame = CGRect(
            x: Double(10),
            y: Double(firstButton),
            width: Double(width - 20),
            height: Double(buttonHeight)
        );
        TagHydrantButton = UIButton(frame: tagHydrantFrame);
        TagHydrantButton.setTitle("Tag Hydrant", forState: UIControlState.Normal);
        TagHydrantButton.addTarget(self, action: #selector(HomeViewController.TagHydrantPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(TagHydrantButton);
        
        /* Nearby Hydrants */
        let nearbyHydrantsFrame = CGRect(
            x: Double(10),
            y: Double(firstButton + buttonHeight + buttonSpacing),
            width: Double(width - 20),
            height: Double(buttonHeight)
        );
        NearbyHydrantsButton = UIButton(frame: nearbyHydrantsFrame);
        NearbyHydrantsButton.setTitle("Nearby Hydrants", forState: UIControlState.Normal);
        NearbyHydrantsButton.addTarget(self, action: #selector(HomeViewController.NearbyHydrantsPresssed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(NearbyHydrantsButton);
        
        /* Map Hydrants */
        let mapFrame = CGRect(
            x: Double(10),
            y: Double(firstButton + 2.0 * buttonHeight + 2.0 * buttonSpacing),
            width: Double(width - 20),
            height: Double(buttonHeight)
        );
        MapButton = UIButton(frame: mapFrame);
        MapButton.setTitle("Map of Hydrants", forState: UIControlState.Normal);
        MapButton.addTarget(self, action: #selector(HomeViewController.MapPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(MapButton);
        
        // Do any additional setup after loading the view, typically from a nib.
        UIFormatHelper.Format(NavBar);
        
        //Top buttons
        UIFormatHelper.Format(AboutButton);
        
        //Other Controls
        UIFormatHelper.Format(MyHydrantCount);
        UIFormatHelper.Format(TagHydrantButton);
        UIFormatHelper.Format(MapButton);
        UIFormatHelper.Format(NearbyHydrantsButton);
       
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
    
    func TagHydrantPressed(sender: AnyObject)
    {
        performSegueWithIdentifier("ShowTagHydrant", sender: nil);
    }
    
    func NearbyHydrantsPresssed(sender: AnyObject)
    {
        performSegueWithIdentifier("ShowNearbyHydrants", sender: nil);
    }
    
    func MapPressed(sender: AnyObject)
    {
        performSegueWithIdentifier("ShowMap", sender: nil);
    }
    
    func AboutPressed(sender: AnyObject)
    {
        performSegueWithIdentifier("ShowAbout", sender: nil);
    }
    
    @IBAction func returnToHome(sender: UIStoryboardSegue)
    {
        //Placeholder
    }

}