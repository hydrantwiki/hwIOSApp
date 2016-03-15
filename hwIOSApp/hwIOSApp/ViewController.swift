//
//  ViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private var user:User?
    @IBOutlet weak var UsernameText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    @IBAction func LoginPressed(sender: AnyObject)
    {
        let service:AuthenticationService = AuthenticationService()
        let username = UsernameText.text
        let password = PasswordText.text

        if ((username ?? "").isEmpty
            || (password ?? "").isEmpty)
        {
            self.ShowOKAlert("HydrantWiki", message: "Username and password required");
            return;
        }
        
        service.login(username!, password: password!) {
            (result:User?) in
            
            if (result != nil)
            {
                self.user = result!
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(result?.Username, forKey: "username")
                defaults.setObject(result?.AuthToken, forKey: "authToken")
                defaults.setObject(result?.DisplayName, forKey: "displayName")
                
                Credentials.GetInstance().userName = self.user!.Username;
                Credentials.GetInstance().userToken = self.user!.AuthToken;
                
                 //Perform segue
                self.performSegueWithIdentifier("ShowHome", sender:nil)
            }
            else
            {
                //Alert
                self.ShowOKAlert("HydrantWiki", message: "Failed to login to server");
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let homeVC = segue.destinationViewController as! HomeViewController
        
        homeVC.user = self.user
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIFormatHelper.Format(LoginButton);
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let username = defaults.stringForKey("username")
        let authToken = defaults.stringForKey("authToken")
        let displayName = defaults.stringForKey("displayName")
        
        if (username != nil && authToken != nil)
        {
            var user = User()
            user.AuthToken = authToken
            user.DisplayName = displayName
            user.Username = username
            
            self.user = user;
            
            Credentials.GetInstance().userName = user.Username;
            Credentials.GetInstance().userToken = user.AuthToken;
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        //TODO - Test to see if the token is still good
        if (self.user != nil)
        {
            self.performSegueWithIdentifier("ShowHome", sender: nil)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

