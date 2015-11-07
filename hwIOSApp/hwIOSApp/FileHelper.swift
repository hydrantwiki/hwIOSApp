//
//  FileHelper.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 11/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import Foundation

public class FileHelper
{
    static func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        return documentsFolderPath
    }
    
    // Get path for a file in the directory
    static func fileInDocumentsDirectory(filename: String) -> String {
        
        let writePath = (documentsDirectory() as NSString).stringByAppendingPathComponent("Mobile")
        
        if (!NSFileManager.defaultManager().fileExistsAtPath(writePath)) {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(writePath, withIntermediateDirectories: false, attributes: nil) }
            catch let error as NSError {
                print(error.localizedDescription);
            }
        }
        return (writePath as NSString).stringByAppendingPathComponent(filename)
    }
}