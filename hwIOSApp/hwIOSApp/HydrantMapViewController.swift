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
    
    override public func viewDidLoad()
    {
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
            height: Int(UIFormatHelper.GetScreenHeight()) - 50
        );
        
        HydrantMap = MKMapView(frame: mapFrame);
        HydrantMap.delegate = self;
        HydrantMap.frame.origin.x = 0;
        HydrantMap.frame.origin.y = 50;
        HydrantMap.zoomEnabled = false;
        HydrantMap.showsUserLocation = false;
        //HydrantMap.mapType = MKMapType.Standard;
        view.addSubview(HydrantMap);
        
        UIFormatHelper.Format(NavBar);
        UIFormatHelper.Format(CancelButton);
        UIFormatHelper.Format(TableViewButton);
        UIFormatHelper.Format(HydrantMap)
    
        //Start the location manager
        locationManager = LocationManager();
        locationManager.locationUpdated = self;
        locationManager!.Start();
    }
    
    public func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool)
    {
        GetHydrants();
    }
    
    public func mapView(
        mapView: MKMapView,
        viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
            if (annotation is MKUserLocation) { return nil }
            
            let reuseID = "hydrant"
            var v = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseID)
            
            if v != nil {
                v!.annotation = annotation
            } else {
                v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
                
                v!.image = UIImage(named:"HydrantPin")
            }
            
            return v
    }
    
    func ZoomToCurrentLocation(latitude:Double, longitude:Double)
    {
        let spanX = 0.0125;
        let spanY = 0.0125;
        
        let location = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
        
        let span = MKCoordinateSpanMake(spanX, spanY)
        let region = MKCoordinateRegion(center: location, span: span)
        
        HydrantMap.setRegion(region, animated: false);
        
        GetHydrants();
    }
    
    func GetHydrants()
    {
        let edgePoints = HydrantMap.edgePoints();
        
        let minLat = edgePoints.sw.latitude;
        let maxLat = edgePoints.ne.latitude;
        let minLon = edgePoints.sw.longitude;
        let maxLon = edgePoints.ne.longitude;
        
        let service = HydrantService()
        service.GetHydrantsInBox(minLat, maxLatitude: maxLat, minLongitude: minLon, maxLongitude: maxLon)
            { (response) -> Void in
            
            if (response != nil
                && response!.Success
                && response!.Hydrants != nil)
            {
                self.AddHydrantsToMap((response?.Hydrants!)!);
            }
        }
    }
    
    func AddHydrantsToMap(hydrants:[HydrantDTO])
    {
        HydrantMap.removeAnnotations( HydrantMap.annotations )
        
        for hydrant in hydrants {
            if (hydrant.Position != nil)
            {
                let hydAnn = HydrantAnnotation(
                    title: "",
                    subtitle: "",
                    coordinate: CLLocationCoordinate2D(
                        latitude: (hydrant.Position?.Latitude)!,
                        longitude: (hydrant.Position?.Longitude)!));
                
                HydrantMap.addAnnotation(hydAnn);
            }
        }
    }
    
    func TableViewButtonPressed(sender: UIBarButtonItem)
    {
        locationManager.Stop();
        self.performSegueWithIdentifier("ShowNearbyTable", sender: nil)
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
        locationManager.Stop();
        
        ZoomToCurrentLocation(latitude, longitude: longitude);
    }
    
}