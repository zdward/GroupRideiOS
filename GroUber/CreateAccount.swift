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
    @IBOutlet weak var RCSID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmed_pass: UITextField!
    @IBOutlet weak var displayName: UITextField!
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //The sign-in function, stores info in firebase authentication
    @IBAction func sign_in(_ sender: Any) {
        var email: String = String(RCSID.text!);
        var keyword: String;
        
        if password.text == confirmed_pass.text {
            keyword = String(password.text!)
        }
        else{
            keyword = "NULL" //return an error in this case
        }
        
        email = email + "@rpi.edu";
        keyword = keyword + "_" //so the outlet is used, really a useless line of code
        
        if email == "" || keyword == "" || displayName.text == "" || confirmed_pass.text == ""{
            createAlert(title: "Error", message: "Please fill out all fields");
            return;
        }  else if String(password.text!).count < 6 {
            createAlert(title: "Error", message: "Password must be at least 6 characters long");
            return;
        } else if password.text != confirmed_pass.text {
            createAlert(title: "Error", message: "Please make sure that passwords match");
            
            password.layer.cornerRadius = 8.0;
            password.layer.masksToBounds = true;
            password.layer.borderColor = UIColor.red.cgColor;
            password.layer.borderWidth = 1.0;
            
            confirmed_pass.layer.cornerRadius = 8.0;
            confirmed_pass.layer.masksToBounds = true;
            confirmed_pass.layer.borderColor = UIColor.red.cgColor;
            confirmed_pass.layer.borderWidth = 1.0;
            
            return;
        }
        else{
            confirmed_pass.layer.cornerRadius = 8.0;
            confirmed_pass.layer.masksToBounds = true;
            confirmed_pass.layer.borderColor = UIColor.clear.cgColor;
            confirmed_pass.layer.borderWidth = 1.0;
            
            password.layer.cornerRadius = 8.0;
            password.layer.masksToBounds = true;
            password.layer.borderColor = UIColor.clear.cgColor;
            password.layer.borderWidth = 1.0;
            
            displayName.layer.cornerRadius = 8.0;
            displayName.layer.masksToBounds = true;
            displayName.layer.borderColor = UIColor.clear.cgColor;
            displayName.layer.borderWidth = 1.0;
            
            //Stores the new user on firebase/authentication
            Auth.auth().createUser(withEmail: email, password: keyword) { authResult, error in
                if error != nil{
                    print("Error creating user: \(error!.localizedDescription)");
                } else {
                    print("User created!")
                    self.performSegue(withIdentifier: "account_created", sender: nil)
                }
            }
        }
    }
}
 
