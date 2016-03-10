//
//  HydrantMapViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit
import MapKit

public class HydrantMapViewController : UIViewController, MKMapViewDelegate, ILocationUpdated
{
    
    public var user:User?;
    
    var locationManager:LocationManager!
    var NavBar: UINavigationBar!
    var CancelButton: UIBarButtonItem!
    var TableViewButton: UIBarButtonItem!
    var HydrantMap: MKMapView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = LocationManager();
        locationManager.locationUpdated = self;
        locationManager.Start()
                
        CancelButton = UIFormatHelper.CreateNavBarButton("Cancel", targetView: self, buttonAction: Selector("CancelSent:"));
        TableViewButton = UIFormatHelper.CreateNavBarButton("Table View", targetView: self, buttonAction: Selector("TableViewButtonPressed:"));
        
        NavBar = UIFormatHelper.CreateNavBar("HydrantWiki", leftButton: CancelButton, rightButton: TableViewButton);
        view.addSubview(NavBar);
        
        //Add TextView
        let mapFrame = CGRect(
            x: 0,
            y: 0,
            width: Int(UIFormatHelper.GetScreenWidth()),
            height: Int(UIFormatHelper.GetScreenHeight())-50);
        
        HydrantMap = MKMapView(frame: mapFrame);
        HydrantMap.delegate = self;
        HydrantMap.frame.origin.x = 0;
        HydrantMap.frame.origin.y = 50;
        HydrantMap.zoomEnabled = false;
        HydrantMap.showsUserLocation = true;
        HydrantMap.mapType = MKMapType.Standard;
        view.addSubview(HydrantMap);
        
        UIFormatHelper.Format(NavBar!);
        UIFormatHelper.Format(CancelButton);
        UIFormatHelper.Format(TableViewButton);
        
        UIFormatHelper.Format(HydrantMap)
    }
    
    
    func ZoomToCurrentLocation(latitude:Double, longitude:Double)
    {
        let spanX = 0.00725;
        let spanY = 0.00725;
        
        var region = MKCoordinateRegion();
        region.center.latitude = latitude;
        region.center.longitude = longitude;
        region.span.latitudeDelta = spanX;
        region.span.longitudeDelta = spanY;
        
        HydrantMap.setRegion(region, animated: true);
    }
    
    func TableViewButtonPressed(sender: AnyObject)
    {
    
    }
    
    func CancelSent(sender: AnyObject)
    {
        locationManager.Stop();
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
    }
    
    public func NewLocation(
        count: Int,
        latitude: Double,
        longitude: Double,
        elevation: Double,
        accuracy: Double)
    {
        ZoomToCurrentLocation(latitude, longitude: longitude);
    }
    
}