//
//  HydrantTableViewCell.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/30/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import UIKit

class HydrantTableViewCell: UITableViewCell
{
    var LatitudeLabel: UILabel = UILabel();
    var LongitudeLabel: UILabel = UILabel();
    var DistanceLabel: UILabel = UILabel();
    var HydrantImage: UIImageView = UIImageView();
        
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.contentView.addSubview(LatitudeLabel);
        self.contentView.addSubview(LongitudeLabel);
        self.contentView.addSubview(DistanceLabel);
        self.contentView.addSubview(HydrantImage);
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        LatitudeLabel.frame = CGRectMake(95, 5, 300, 20);
        LongitudeLabel.frame = CGRectMake(95, 30, 300, 20);
        DistanceLabel.frame = CGRectMake(95, 55, 300, 20);
        HydrantImage.frame = CGRectMake(0, 5, 80, 80);
    }
    
    func Populate(hydrant:HydrantDTO)
    {
        if (hydrant.Position != nil)
        {
            LatitudeLabel.text = "Latitude: " + String(hydrant.Position!.Latitude!.roundToPlaces(5));
            LongitudeLabel.text = "Longitude: " + String(hydrant.Position!.Longitude!.roundToPlaces(5));
        }

        DistanceLabel.text = "Distance: " + String(hydrant.DistanceInFeet!.roundToPlaces(0)) + " ft";
        
        if (hydrant.ImageUrl == nil)
        {
            HydrantImage.image = UIImage(named:"NoImage");
        }
        else
        {
            let url = NSURL(string: hydrant.ThumbnailUrl!);
            let data = NSData(contentsOfURL: url!); //make sure your image in this url does exist, otherwise unwrap in a if let check
            
            if (data != nil)
            {
                HydrantImage.image = UIImage(data: data!);
            }
            else
            {
                HydrantImage.image = UIImage(named:"NoImage");
            }
        }
    }
}
