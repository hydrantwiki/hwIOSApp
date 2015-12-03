//
//  HydrantTableViewCell.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/30/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import UIKit

class HydrantTableViewCell: UITableViewCell {

    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var DetailsLabel: UILabel!
    @IBOutlet weak var HydrantImage: UIImageView!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
