//
//  ViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var UsernameLabel: UITextField!
    
    @IBOutlet weak var PasswordLabel: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBAction func LoginPressed(sender: AnyObject) {
        let service:AuthenticationService = AuthenticationService()
        let username = UsernameLabel.text
        let password = PasswordLabel.text
        
        service.login(username!, password: password!) {
            (result:User?) in
            
            if (result != nil)
            {
                //Perform segue
            }
            else
            {
                //Alert
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

