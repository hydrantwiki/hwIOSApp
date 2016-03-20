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
    var locationManager:AveragingLocationManager?
    let imagePicker = UIImagePickerController()
    
    var NavBar: UINavigationBar!
    var CancelButton: UIBarButtonItem!
    var SaveButton: UIBarButtonItem!
    var TakePhotoButton: UIButton!
    var LatitudeLabel: UILabel!
    var LongitudeLabel: UILabel!
    var AccuracyLabel: UILabel!
    var CountLabel: UILabel!
    var HydrantImage: UIImageView!
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager = AveragingLocationManager();
        locationManager!.locationAverageUpdated = self;
        
        /* setup the Navbar */
        SaveButton = UIFormatHelper.CreateNavBarButton(
            "Save",
            targetView: self,
            buttonAction: Selector("SavePressed:"));
        UIFormatHelper.Format(SaveButton);
        SaveButton.enabled = false;
        
        CancelButton = UIFormatHelper.CreateNavBarButton(
            "Cancel",
            targetView: self,
            buttonAction: Selector("CancelPressed:"));
        UIFormatHelper.Format(CancelButton);
        
        NavBar = UIFormatHelper.CreateNavBar("HydrantWiki", leftButton: CancelButton, rightButton: SaveButton);
        view.addSubview(NavBar);
        UIFormatHelper.Format(NavBar);
        
        /* Setup Latitude */
        let latitudeFrame = UIFormatHelper.GetFrameByPercent(0.05, yPercent:0.10, widthPercent:0.90, heightPercent:0.05);
        LatitudeLabel = UILabel(frame: latitudeFrame);
        LatitudeLabel.text = "Latitude:";
        view.addSubview(LatitudeLabel);
        UIFormatHelper.Format(LatitudeLabel);
        
        /* Setup Longitude */
        let longitudeFrame = UIFormatHelper.GetFrameByPercent(0.05, yPercent:0.15, widthPercent:0.90, heightPercent:0.05);
        LongitudeLabel = UILabel(frame: longitudeFrame);
        LongitudeLabel.text = "Longitude:";
        view.addSubview(LongitudeLabel);
        UIFormatHelper.Format(LongitudeLabel);
        
        /* Setup Accuracy */
        let accuracyFrame = UIFormatHelper.GetFrameByPercent(0.05, yPercent:0.20, widthPercent:0.90, heightPercent:0.05);
        AccuracyLabel = UILabel(frame: accuracyFrame);
        AccuracyLabel.text = "Accuracy (m):";
        view.addSubview(AccuracyLabel);
        UIFormatHelper.Format(AccuracyLabel);
        
        /* Count */
        let countFrame = UIFormatHelper.GetFrameByPercent(0.05, yPercent:0.25, widthPercent:0.90, heightPercent:0.05);
        CountLabel = UILabel(frame: countFrame);
        CountLabel.text = "Count:";
        view.addSubview(CountLabel);
        UIFormatHelper.Format(CountLabel);
        
        /* Setup Image */
        let hydrantImageFrame = UIFormatHelper.GetFrameByPercent(0.15, yPercent:0.30, widthPercent:0.70, heightPercent:0.55);
        HydrantImage = UIImageView(frame:hydrantImageFrame);
        HydrantImage.layer.borderColor = UIColor.blackColor().CGColor;
        HydrantImage.layer.borderWidth = 1;
        view.addSubview(HydrantImage);

        /* Create Button */
        let takePhotoButtonFrame = UIFormatHelper.GetFrameByPercent(0.05, yPercent: 0.87, widthPercent: 0.90, heightPercent: 0.10);
        TakePhotoButton = UIButton(frame: takePhotoButtonFrame);
        TakePhotoButton.setTitle("Take Photo", forState: UIControlState.Normal);
        TakePhotoButton.addTarget(self, action: "TakePhotoPressed:", forControlEvents: .TouchUpInside)
        UIFormatHelper.Format(TakePhotoButton);
        view.addSubview(TakePhotoButton);
        
        /* ImagePicker */
        imagePicker.delegate = self;
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) == nil
        {
            TakePhotoButton.enabled = false;
        }
        
        StartGPSCollection();
    }
    
    func SavePressed(sender: AnyObject)
    {
        SaveButton.enabled = false;
        
        var tag:TagDTO = TagDTO();
        
        let location = locationManager?.locationAverage.getAverage();
        
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
                ImageHelper.saveImage(image!,path:writePath, imageQuality:UIConstants.ImageQuality);
                
                SaveImage(writePath, fileName:imageName!, tag: tag);
            }
            else
            {
                SaveTag(tag);
            }
        }
    }
    
    //Saves the Image then the Tag
    func SaveImage(writePath:String, fileName:String, tag:TagDTO)
    {
        let service = TagService();

        service.SaveImage(
            writePath,
            fileName:fileName,
            completion: { (response) -> Void in
                self.SaveTag(tag);
        });
    }
    
    //Save the Tag
    func SaveTag(tag:TagDTO)
    {
        let service = TagService();
        
        service.SaveTag(tag,
            completion: { (response) -> Void in
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
                    self.presentViewController(uiAlert, animated: true, completion: nil);
                    
                    uiAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil)
                        }
                        )
                    );
                }
            }
        )
    }
    
    func StartGPSCollection()
    {
        locationManager!.Start(){ (count:Int, location:Location?) in
            if (location != nil)
            {
                self.CountLabel.text = "Count: 10";
                self.LatitudeLabel.text = "Latitude: " + String(location!.latitude!);
                self.LongitudeLabel.text = "Longitude: " + String(location!.longitude!);
                self.AccuracyLabel.text = "Accuracy (m): " + String(location!.accuracy!);
                self.SaveButton.enabled = true;
            }
        }
    }
    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?)
    {
        HydrantImage.contentMode = .ScaleAspectFit;
        HydrantImage.image = image;
    
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    public func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

    public func NewLocation(
        count: Int,
        latitude: Double,
        longitude: Double,
        elevation: Double,
        accuracy: Double)
    {
        CountLabel.text = "Count: " + String(count);
        LatitudeLabel.text = "Latitude: " + String(latitude);
        LongitudeLabel.text = "Longitude: " + String(longitude);
        AccuracyLabel.text = "Accuracy (m): " + String(accuracy);
    }
    
    func TakePhotoPressed(sender: AnyObject)
    {
        imagePicker.allowsEditing = false;
        imagePicker.sourceType = .Camera;
        imagePicker.cameraCaptureMode = .Photo;
        
        presentViewController(imagePicker, animated: true) { () -> Void in
            
        }
    }
    
    func CancelPressed(sender: AnyObject)
    {
        self.performSegueWithIdentifier("returnToHomeSegue", sender: nil);
    }
}
