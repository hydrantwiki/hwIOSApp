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
        //HydrantMap.showsUserLocation = true;
        //HydrantMap.mapType = MKMapType.Standard;
        view.addSubview(HydrantMap);
        
        UIFormatHelper.Format(NavBar);
        UIFormatHelper.Format(CancelButton);
        UIFormatHelper.Format(TableViewButton);
        UIFormatHelper.Format(HydrantMap)
    
        //Start the location manager
        locationManager = LocationManager();
        locationManager.locationUpdated = self;
    }
    
    override public func viewDidAppear(animated: Bool) {
        StartGPSCollection();
    }
    
    private func StartGPSCollection()
    {
        locationManager!.Start();
    }

    func ZoomToCurrentLocation(latitude:Double, longitude:Double)
    {
        let spanX = 0.5;
        let spanY = 0.5;
        
        let location = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
        
        let span = MKCoordinateSpanMake(spanX, spanY)
        let region = MKCoordinateRegion(center: location, span: span)
        
        HydrantMap.setRegion(region, animated: true);
    }
    
    func TableViewButtonPressed(sender: UIBarButtonItem)
    {
    
    }
    
    func CancelSent(sender: UIBarButtonItem)
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