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
    //var activityIndicator = UIActivityIndicatorView()
    //So we can interact with the RCS_ID text field
    //@IBOutlet weak var RCS_ID: UITextField!
    //So we can interact with the password text field
  //  @IBOutlet weak var pass: UITextField!
    //So we can interact with the confirmed password text field
   // @IBOutlet weak var confirmed_pass: UITextField!
    
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
        //Stores the new user on firebase/authentication
        Auth.auth().createUser(withEmail: email, password: keyword) { authResult, error in //...
        }
        //Animation and perform segue below
        //buffering, cannot interact with screen
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        self.activityIndicator.stopAnimating() //temp
        UIApplication.shared.endIgnoringInteractionEvents() //temp
        performSegue(withIdentifier: "account_created", sender: nil)
    }
}
 
