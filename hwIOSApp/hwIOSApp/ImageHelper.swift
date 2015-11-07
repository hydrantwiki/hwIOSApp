//
//  ImageHelper.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

public class ImageHelper
{
    static func saveImage (image: UIImage, path: String ) -> Bool{
        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        let result = jpgImageData!.writeToFile(path, atomically: true)
        
        return result
    }
}