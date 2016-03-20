//
//  NearbyHydrantsViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class NearbyHydrantsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    public var user:User?;
    var locationManager:LocationManager!;
    var hydrants:[HydrantDTO] = [];
    
    var NavBar: UINavigationBar!;
    var CancelButton: UIBarButtonItem!;
    var MapViewButton: UIBarButtonItem!;
    var HydrantTableView: UITableView!;
    var lastLocationTime:NSDate? = nil;
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        
        CancelButton = UIFormatHelper.CreateNavBarButton(
            "Cancel",
            targetView: self,
            buttonAction: Selector("CancelSent:"));
        
        MapViewButton = UIFormatHelper.CreateNavBarButton(
            "Map View",
            targetView: self,
            buttonAction: Selector("MapViewButtonPressed:"));
        
        NavBar = UIFormatHelper.CreateNavBar("Nearby Hydrants", leftButton: CancelButton, rightButton: MapViewButton);
        view.addSubview(NavBar);
        
        let tableFrame = CGRect(
            x: 0,
            y: 0,
            width: Int(UIFormatHelper.GetScreenWidth()) - 16,
            height: Int(UIFormatHelper.GetScreenHeight()) - 66
        );
        
        HydrantTableView = UITableView(frame: tableFrame);
        HydrantTableView.delegate = self;
        HydrantTableView.dataSource = self;
        HydrantTableView.frame.origin.x = 8;
        HydrantTableView.frame.origin.y = 58;
        HydrantTableView.rowHeight = 90;
        view.addSubview(HydrantTableView);
               
        UIFormatHelper.Format(NavBar);
        UIFormatHelper.Format(CancelButton);
        UIFormatHelper.Format(MapViewButton);
        
        //Start the location manager
        locationManager = LocationManager();
        locationManager!.Start();
        
        NSTimer.scheduledTimerWithTimeInterval(
            0.25,
            target: self,
            selector: "CheckForNewLocation",
            userInfo: nil,
            repeats: false);
    }
    
    func CheckForNewLocation()
    {
        let location:Location? = LocationCache.Instance.LastLocation;
        
        if (location != nil)
        {
            if (lastLocationTime == nil
                || lastLocationTime!.isLessThanDate((location?.dateTime)!))
            {
                lastLocationTime = location!.dateTime;
                LoadHydrants(location!);
            }
            
            NSTimer.scheduledTimerWithTimeInterval(
                30,
                target: self,
                selector: "CheckForNewLocation",
                userInfo: nil,
                repeats: false);
        }
        else
        {
            NSTimer.scheduledTimerWithTimeInterval(
                1.0,
                target: self,
                selector: "CheckForNewLocation",
                userInfo: nil,
                repeats: false);
        }
    }
    
    func LoadHydrants(location:Location)
    {
        let hydrantService = HydrantService();
        
        hydrantService.GetHydrantsInCircle(
            location.latitude!,
            longitude: location.longitude!,
            distance: 300,
            completion: { (response) -> Void in
                if (response != nil)
                {
                    if (response!.Success)
                    {
                        if (response!.Hydrants != nil)
                        {
                            self.hydrants = response!.Hydrants!;
                        }
                        else
                        {
                            self.hydrants = [];
                        }
                        
                        self.RefreshTable();
                    }
                }
        });
    }
    
    func MapViewButtonPressed(sender: UIBarButtonItem)
    {
        locationManager.Stop();
        self.performSegueWithIdentifier("ShowMapOfNearby", sender: nil);
    }
    
    func CancelSent(sender: UIBarButtonItem) {
        locationManager.Stop();
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil);
    }
    
    public func RefreshTable()
    {
        HydrantTableView.reloadData();
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return hydrants.count;
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "HydrantTableViewCell";
        let cell:HydrantTableViewCell = HydrantTableViewCell(
            style: UITableViewCellStyle.Subtitle,
            reuseIdentifier: cellIdentifier);
        
        // Configure the cell...
        let hydrant = hydrants[indexPath.row];
        cell.Populate(hydrant);
        return cell;
    }
    
    // MARK:  UITableViewDelegate Methods
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
//    public func NewLocation(
//        count: Int,
//        latitude: Double,
//        longitude: Double,
//        elevation: Double,
//        accuracy: Double)
//    {
//        let hydrantService = HydrantService();
//        
//        hydrantService.GetHydrantsInCircle(
//            latitude,
//            longitude: longitude,
//            distance: 300,
//            completion: { (response) -> Void in                
//                if (response != nil)
//                {
//                    if (response!.Success)
//                    {
//                        if (response!.Hydrants != nil)
//                        {
//                            self.hydrants = response!.Hydrants!;
//                        }
//                        else
//                        {
//                            self.hydrants = [];
//                        }
//                        
//                        self.RefreshTable();
//                    }
//                }
//        });
//    }
}