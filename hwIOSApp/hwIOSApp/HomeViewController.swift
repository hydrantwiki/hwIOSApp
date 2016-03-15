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
    
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        
        let height:Float = UIFormatHelper.GetScreenHeight();
        let width:Float = UIFormatHelper.GetScreenWidth();
        
        /* setup the Navbar */
        AboutButton = UIFormatHelper.CreateNavBarButton(
            "About",
            targetView: self,
            buttonAction: Selector("AboutPressed:"));
        
        NavBar = UIFormatHelper.CreateNavBar("HydrantWiki", leftButton: nil, rightButton: AboutButton);
        view.addSubview(NavBar);
        
        /* Setup other controls */
        let countFrame = CGRect(
            x: 10,
            y: 60,
            width: Int(UIFormatHelper.GetScreenWidth()) - 20,
            height: 25
        );
        MyHydrantCount = UILabel(frame: countFrame);
        MyHydrantCount.text = "Hydrants Tagged : Loading...";
        view.addSubview(MyHydrantCount);
        
        /* Tag Hydrant */
        let tagHydrantFrame = CGRect(
            x: 10,
            y: 100,
            width: Int(UIFormatHelper.GetScreenWidth()) - 20,
            height: 25
        );
        TagHydrantButton = UIButton(frame: tagHydrantFrame);
        TagHydrantButton.setTitle("Tag Hydrant", forState: UIControlState.Normal);
        TagHydrantButton.addTarget(self, action: "TagHydrantPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(TagHydrantButton);
        
        /* Nearby Hydrants */
        let nearbyHydrantsFrame = CGRect(
            x: 10,
            y: 150,
            width: Int(UIFormatHelper.GetScreenWidth()) - 20,
            height: 25
        );
        NearbyHydrantsButton = UIButton(frame: nearbyHydrantsFrame);
        NearbyHydrantsButton.setTitle("Nearby Hydrants", forState: UIControlState.Normal);
        NearbyHydrantsButton.addTarget(self, action: "NearbyHydrantsPresssed:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(NearbyHydrantsButton);
        
        /* Map Hydrants */
        let mapFrame = CGRect(
            x: 10,
            y: 200,
            width: Int(UIFormatHelper.GetScreenWidth()) - 20,
            height: 25
        );
        MapButton = UIButton(frame: mapFrame);
        MapButton.setTitle("Map of Hydrants", forState: UIControlState.Normal);
        MapButton.addTarget(self, action: "MapPressed:", forControlEvents: UIControlEvents.TouchUpInside)
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