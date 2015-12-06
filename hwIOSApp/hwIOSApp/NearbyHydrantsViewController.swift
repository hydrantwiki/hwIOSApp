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
    var locationManager:LocationManager?;
    var hydrantService:HydrantService?;
    var hydrants:[HydrantDTO] = [];
    
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var HydrantTableView: UITableView!
    @IBOutlet weak var MapViewButton: UIBarButtonItem!
    @IBOutlet weak var NavBar: UINavigationBar!
    
    
    @IBAction func CanceSent(sender: AnyObject) {
        if (locationManager != nil)
        {
            locationManager?.Stop();
        }
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)        
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        locationManager = LocationManager();
        locationManager!.locationUpdated = self;
        locationManager!.OnlyOnce = true;
        locationManager!.Start();
        
        UIFormatHelper.Format(NavBar);
        UIFormatHelper.Format(CancelButton);
        UIFormatHelper.Format(MapViewButton);
        UIFormatHelper.Format(HydrantTableView);
        
        hydrantService = HydrantService();
        HydrantTableView.delegate = self;
        HydrantTableView.dataSource = self;
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HydrantTableViewCell
        
        // Configure the cell...
        let hydrant = hydrants[indexPath.row]
        
        cell.DistanceLabel.text = "";
        cell.LocationLabel.text = hydrant.Position!.GetLocationString();
        cell.DetailsLabel.text = "";
        cell.HydrantImage = nil;
        
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
        accuracy: Double) {
            hydrantService?.GetNearbyHydrants(
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
            })
    }
}