//
//  CreateAccount.swift
//  GroUber
//
//  Created by Zachary Ward on 2/16/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit
import Firebase

class CreateAccount: UIViewController{
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var rcsID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirm_password: UITextField!
    
    
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: false, completion: nil)
        }))
        self.present(alert, animated: false, completion: nil)
    }
    
    //The register function, stores info in firebase authentication
    @IBAction func register(_ sender: Any) {
        // check if all fields have been filled out
        if String(rcsID.text!) == "" ||
            String(password.text!) == "" ||
            String(confirm_password.text!) == "" {
            self.createAlert(title: "ERROR", message: "Please make sure to fill out all fields")
        }
        // check if password is correctly confirmed
        if password.text! != confirm_password.text! {
            self.createAlert(title: "ERROR", message: "Please make sure the passwords match");
        }
        // check if password is 6 characters or longer
        if password.text!.count < 6 {
            self.createAlert(title: "ERROR", message: "Password must be at least 6 characters");
        }
        
        let email: String = String(rcsID.text!) + "@rpi.edu"
        let userPassword = String(password.text!)
        //Stores the new user on firebase/authentication
        Auth.auth().createUser(withEmail: email, password: userPassword) { authResult, error in
            if error != nil{
                print("Error creating user: \(error!.localizedDescription)");
            } else {
                // successfully created user account and stored in database
                print("User created!")
                // log-in the user with the account they created
                Auth.auth().signIn(withEmail: email, password: userPassword) { user, error in
                    if error != nil{
                        print("Error logging in: \(error!.localizedDescription)");
                        self.createAlert(title: "ERROR", message: "Couldn't log in. Please try again")
                    } else {
                        // successfully logged in the user to their new account
                        // send email verification to user's email address
                        // make this alert appear in the log in page?..
                        // self.createAlert(title: "Email Verification", message: "Please verify your email address by clicking on the link in the email sent to your email address.");
                        Auth.auth().currentUser?.sendEmailVerification { (error) in
                            if error != nil{
                                print("Error sending email address verification: \(error!.localizedDescription)");
                            } else {
                                self.performSegue(withIdentifier: "account_created", sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
}
 
