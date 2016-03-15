//
//  UIViewControllerExtension.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 12/5/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func ShowOKAlert(title:String, message:String)
    {
        AlertHelper.ShowOkAlert(title, message: message, controller: self)
    }
}