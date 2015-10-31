//
//  TagHydrantViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/18/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

public class TagHydrantViewController : UIViewController, ILocationUpdated, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public var user:User?;
    
    @IBOutlet weak var CancelButton: UIBarButtonItem!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var TakePhotoButton: UIButton!
    @IBOutlet weak var LatitudeLabel: UILabel!
    @IBOutlet weak var LongitudeLabel: UILabel!
    @IBOutlet weak var AccuracyLabel: UILabel!
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var HydrantImage: UIImageView!
    
    var locationManager:LocationManager?
    let imagePicker = UIImagePickerController()
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager = LocationManager()
        locationManager!.locationAverageUpdated = self
        
        imagePicker.delegate = self
        
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) == nil {
            TakePhotoButton.enabled = false
        }
        
        TakePhotoButton.backgroundColor = UIConstants.ButtonBackgroundColor
        TakePhotoButton.setTitleColor( UIConstants.ButtonTextColor, forState: UIControlState.Normal)
        TakePhotoButton.setTitleColor( UIConstants.ButtonTextDisabledColor, forState: UIControlState.Disabled)
        TakePhotoButton.layer.cornerRadius = 10
        TakePhotoButton.clipsToBounds = true
        
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager!.Start(){ (count:Int, location:Location?) in
            if (location != nil)
            {
                self.CountLabel.text = "Count: 10"
                self.LatitudeLabel.text = "Latitude: " + String(location!.latitude!)
                self.LongitudeLabel.text = "Longitude: " + String(location!.longitude!)
                self.AccuracyLabel.text = "Accuracy (m): " + String(location!.accuracy!)            }
        }
    }
    
    @IBAction func TakePhotoPressed(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        imagePicker.cameraCaptureMode = .Photo
        
        presentViewController(imagePicker, animated: true) { () -> Void in
            
        }
        
    }
    
    
    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        HydrantImage.contentMode = .ScaleAspectFit
        HydrantImage.image = image
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    

    public func NewLocationAverage(
        count: Int,
        latitude: Double,
        longitude: Double,
        elevation: Double,
        accuracy: Double) {
        
            CountLabel.text = "Count: " + String(count)
            LatitudeLabel.text = "Latitude: " + String(latitude)
            LongitudeLabel.text = "Longitude: " + String(longitude)
            AccuracyLabel.text = "Accuracy (m): " + String(accuracy)
        
    }
    
    
    @IBAction func CancelSent(sender: AnyObject) {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
    }
}
