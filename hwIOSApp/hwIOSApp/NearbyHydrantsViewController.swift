//
//  NearbyHydrantsViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class NearbyHydrantsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, ILocationUpdated
{
    
    public var user:User?;
    var locationManager:LocationManager!;
    var hydrants:[HydrantDTO] = [];
    
    var NavBar: UINavigationBar!;
    var CancelButton: UIBarButtonItem!;
    var MapViewButton: UIBarButtonItem!;
    var HydrantTableView: UITableView!;
    var lastLocationTime:NSDate? = nil;
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NearbyHydrantsViewController.RefreshTable(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    override public func viewDidLoad()
    {
        super.viewDidLoad();
        
        CancelButton = UIFormatHelper.CreateNavBarButton(
            "Cancel",
            targetView: self,
            buttonAction: #selector(NearbyHydrantsViewController.CancelSent(_:)));
        
        MapViewButton = UIFormatHelper.CreateNavBarButton(
            "Map View",
            targetView: self,
            buttonAction: #selector(NearbyHydrantsViewController.MapViewButtonPressed(_:)));
        
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

        HydrantTableView.addSubview(self.refreshControl)
        
        UIFormatHelper.Format(NavBar);
        UIFormatHelper.Format(CancelButton);
        UIFormatHelper.Format(MapViewButton);
        
        //Start the location manager
        locationManager = LocationManager();
        locationManager.locationUpdated = self;
        locationManager!.Start();
        
        CheckForNewLocation();
    }
    
    func RefreshTable(refreshControl: UIRefreshControl)
    {
        CheckForNewLocation();
        refreshControl.endRefreshing();
    }
    
    public func NewLocation(count:Int, latitude:Double, longitude:Double, elevation:Double, accuracy:Double)
    {
        //This is used for the first time.  After that it uses the cached location
        TestForNewLocation();
        locationManager.locationUpdated = nil;
    }
    
    func CheckForNewLocation()
    {
        TestForNewLocation();
    }
    
    func TestForNewLocation()
    {
        let location:Location? = LocationCache.Instance.LastLocation;
        
        if (location != nil)
        {
            if (lastLocationTime == nil
                || lastLocationTime!.isLessThanDate((location?.dateTime)!))
            {
                lastLocationTime = location!.dateTime;
                LoadHydrants(location!);
                
                return;
            }
        }
    }
    
    func LoadHydrants(location:Location)
    {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT;
        dispatch_async(dispatch_get_global_queue(priority, 0))
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
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue())
                    {
                        self.HydrantTableView.reloadData();
                    }
            });
        }

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
}