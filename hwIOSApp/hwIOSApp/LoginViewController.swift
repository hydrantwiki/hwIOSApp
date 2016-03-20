//
//  ViewController.swift
//  hwIOSApp
//
//  Created by Brian Nelson on 10/6/15.
//  Copyright © 2015 Brian Nelson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    private var user:User?
    
    var Header: UILabel!;
    var UsernameText: UITextField!;
    var PasswordText: UITextField!;
    var LoginButton: UIButton!;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let headerFrame = UIFormatHelper.GetFrameByPercent(0.05, yPercent: 0.05, widthPercent: 0.90, heightPercent: 0.10);
        Header = UILabel(frame: headerFrame);
        Header.layer.borderWidth = 0;
        Header.text = "HydrantWiki";
        UIFormatHelper.FormatAsHeader(Header);
        view.addSubview(Header);
        
        let usernameFrame = UIFormatHelper.GetFrameByPercent(0.05, yPercent: 0.25, widthPercent: 0.90, heightPercent: 0.05);
        UsernameText = UITextField(frame: usernameFrame);
        UsernameText.placeholder = "Username";
        UsernameText.autocapitalizationType = UITextAutocapitalizationType.None;
        UsernameText.autocorrectionType = UITextAutocorrectionType.No;
        UIFormatHelper.Format(UsernameText);
        view.addSubview(UsernameText);

        let passwordFrame = UIFormatHelper.GetFrameByPercent(0.05, yPercent: 0.35, widthPercent: 0.90, heightPercent: 0.05);
        PasswordText = UITextField(frame: passwordFrame);
        PasswordText.placeholder = "Password";
        PasswordText.secureTextEntry = true;
        PasswordText.autocapitalizationType = UITextAutocapitalizationType.None;
        PasswordText.autocorrectionType = UITextAutocorrectionType.No;
        UIFormatHelper.Format(PasswordText);
        view.addSubview(PasswordText);
        
        let loginFrame = UIFormatHelper.GetFrameByPercent(0.05, yPercent: 0.45, widthPercent: 0.90, heightPercent: 0.10);
        LoginButton = UIButton(frame: loginFrame);
        LoginButton.setTitle("Login", forState: UIControlState.Normal);
        LoginButton.addTarget(self, action: "LoginPressed:", forControlEvents: .TouchUpInside)
        UIFormatHelper.Format(LoginButton);
        view.addSubview(LoginButton);
                
        //Load the existing login info if present
        let defaults = NSUserDefaults.standardUserDefaults();
        let username = defaults.stringForKey("username");
        let authToken = defaults.stringForKey("authToken");
        let displayName = defaults.stringForKey("displayName");
        
        if (username != nil && authToken != nil)
        {
            var user = User();
            user.AuthToken = authToken;
            user.DisplayName = displayName;
            user.Username = username;
            
            self.user = user;
            
            Credentials.GetInstance().userName = user.Username;
            Credentials.GetInstance().userToken = user.AuthToken;
        }
    }
    
    func LoginPressed(sender: AnyObject)
    {
        let service:AuthenticationService = AuthenticationService();
        let username = UsernameText.text;
        let password = PasswordText.text;

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
                
                let defaults = NSUserDefaults.standardUserDefaults();
                defaults.setObject(result?.Username, forKey: "username");
                defaults.setObject(result?.AuthToken, forKey: "authToken");
                defaults.setObject(result?.DisplayName, forKey: "displayName");
                
                Credentials.GetInstance().userName = self.user!.Username;
                Credentials.GetInstance().userToken = self.user!.AuthToken;
                
                 //Perform segue
                self.performSegueWithIdentifier("ShowHome", sender:nil);
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
        let homeVC = segue.destinationViewController as! HomeViewController;
        homeVC.user = self.user;
    }
    
    override func viewDidAppear(animated: Bool)
    {
        //TODO - Test to see if the token is still good
        if (self.user != nil)
        {
            self.performSegueWithIdentifier("ShowHome", sender: nil);
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
}

