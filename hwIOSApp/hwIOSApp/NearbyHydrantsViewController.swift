//
//  NearbyHydrantsViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class NearbyHydrantsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, ILocationUpdated {
    
    public var user:User?;
    var locationManager:LocationManager!;
    var hydrants:[HydrantDTO] = [];
    
    var NavBar: UINavigationBar!
    var CancelButton: UIBarButtonItem!
    var MapViewButton: UIBarButtonItem!
    var HydrantTableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
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
            height: Int(UIFormatHelper.GetScreenHeight()) - 66);
        
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
        //UIFormatHelper.Format(HydrantTableView);
        
        //Start the location manager
        locationManager = LocationManager();
        locationManager.locationUpdated = self;
        locationManager!.Start();
    }
    
    func MapViewButtonPressed(sender: UIBarButtonItem)
    {
        locationManager.Stop();
        self.performSegueWithIdentifier("ShowMapOfNearby", sender: nil)
    }
    
    func CancelSent(sender: UIBarButtonItem) {
        locationManager.Stop();
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
    }
    
    public func RefreshTable()
    {
        HydrantTableView.reloadData();
    }
    
    // MARK:  UITextFieldDelegate Methods
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hydrants.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "HydrantTableViewCell";
        
        let cell:HydrantTableViewCell = HydrantTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        
        // Configure the cell...
        let hydrant = hydrants[indexPath.row]
        
        cell.Populate(hydrant);
        
        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    public func NewLocation(
        count: Int,
        latitude: Double,
        longitude: Double,
        elevation: Double,
        accuracy: Double)
    {
        let hydrantService = HydrantService();
        
        hydrantService.GetHydrantsInCircle(
            latitude,
            longitude: longitude,
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
}