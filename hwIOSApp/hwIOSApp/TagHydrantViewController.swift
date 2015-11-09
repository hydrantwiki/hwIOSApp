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
    
    @IBOutlet var NavBar: UINavigationBar!
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
        
        UIFormatHelper.Format(NavBar);
        
        //Top Button
        UIFormatHelper.Format(CancelButton)
        UIFormatHelper.Format(SaveButton)
        SaveButton.enabled = false;
        
        //Labels
        UIFormatHelper.Format(LatitudeLabel);
        UIFormatHelper.Format(LongitudeLabel);
        UIFormatHelper.Format(AccuracyLabel);
        UIFormatHelper.Format(CountLabel);
        
        //Buttons
        UIFormatHelper.Format(TakePhotoButton);
        
    }
    
    @IBAction func SavePressed(sender: AnyObject) {
        SaveButton.enabled = false;
        
        var tag:TagDTO = TagDTO()
        
        let location = locationManager?.locationAverage.getAverage()
        
        if (location != nil)
        {
            tag.Position = PositionDTO(location: location!, wasAveraged: true);
 
            var image:UIImage? = nil;
            var imageName:String? = nil;
            
            if (HydrantImage.image != nil)
            {
                tag.AssignImageGuid();
                
                image = HydrantImage.image
                imageName = tag.ImageGuid! + ".jpg";
                
                let writePath = FileHelper.fileInDocumentsDirectory(imageName!);
                ImageHelper.saveImage(image!,path:writePath);
                
                SaveImage(writePath, fileName:imageName!, tag: tag);
            }
            else
            {
                SaveTag(tag);
            }
        }
    }
    
    //Saves the Image then the Tag
    private func SaveImage(writePath:String, fileName:String, tag:TagDTO)
    {
        let service = TagService()
        service.SaveImage(writePath,
            fileName:fileName,
            completion: { (response) -> Void in
                let uiAlert = UIAlertController(title: "HydrantWiki",
                    message: response!.Message!,
                    preferredStyle: UIAlertControllerStyle.Alert);
                self.presentViewController(uiAlert, animated: true, completion: nil)
                
                uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                    
                    }
                    )
                )

                
                self.SaveTag(tag);
        })
    }
    
    //Save the Tag
    private func SaveTag(tag:TagDTO)
    {
        let service = TagService()
        
        service.SaveTag(tag
            , completion: { (response) -> Void in
                if (response != nil)
                {
                    let title:String = "HydrantWiki";
                    var message:String = "";
                    
                    if (response!.Success)
                    {
                        message = "Saved to server";
                    }
                    else
                    {
                        message = "Unable to save.  Will try again later";
                    }
                    
                    let uiAlert = UIAlertController(title: title,
                        message: message,
                        preferredStyle: UIAlertControllerStyle.Alert);
                    self.presentViewController(uiAlert, animated: true, completion: nil)
                    
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
                        }
                        )
                    )
                }
            }
        )
    }
    
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager!.Start(){ (count:Int, location:Location?) in
            if (location != nil)
            {
                self.CountLabel.text = "Count: 10"
                self.LatitudeLabel.text = "Latitude: " + String(location!.latitude!)
                self.LongitudeLabel.text = "Longitude: " + String(location!.longitude!)
                self.AccuracyLabel.text = "Accuracy (m): " + String(location!.accuracy!)
                
                self.SaveButton.enabled = true;
            }
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
