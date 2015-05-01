//
//  RegistrationViewController.swift
//  Parse
//
//  Created by Matthew Carroll on 4/30/15.
//  Copyright (c) 2015 blarg. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.text = "alex.bryan+12@rd.io"
        passwordField.text = "password"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignInClicked(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(emailField.text, password: passwordField.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                println("User Exist")
                self.performSegueWithIdentifier("ChatSegue", sender: self)
            } else {
                println("user error with login")
            }
        }
    }
    
    @IBAction func onSignUpClicked(sender: AnyObject) {
        let user = PFUser()
        
        user.username = emailField.text
        user.password = passwordField.text
        user.email = emailField.text
        
        user.signUpInBackgroundWithBlock() {
            (succeded: Bool?, error: NSError?) -> Void in
            if let error = error {
                println("Sign Up failed")
            } else {
                println("Sign Up succeeded")
                self.performSegueWithIdentifier("ChatSegue", sender: self)
            }
        }
        
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
