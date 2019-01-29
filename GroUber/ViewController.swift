//
//  ViewController.swift
//  GroUber
//
//  Created by Zachary Ward on 1/17/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var username_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    
    var activityIndicator = UIActivityIndicatorView()
    var signup_mode = true; //WILL SAVE THIS IN USERDEFAULTS LATER, saved pass and username feature, maybe attempt autologin
    
    //displays an alert to the view controller
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //when the login button is pressed
    @IBAction func Login_Button_Action(_ sender: Any) {
        //Alex's addition: When the fields are blank, an error is returned
        if username_field.text == "" || password_field.text == "" {
            createAlert(title: "ERROR", message: "Invalid Username/Password")
            
        } else {
            
            //buffering, cannot interact with screen
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            
            //this will be the code to get the username and password from the server and then login to their profile
            if signup_mode {
                //create a user utilizing the database
                self.activityIndicator.stopAnimating() //temp
                UIApplication.shared.endIgnoringInteractionEvents() //temp
                performSegue(withIdentifier: "Login_Segue", sender: nil)
            } else {
          //fetch for user and if exists, login
                self.activityIndicator.stopAnimating() //temp
                UIApplication.shared.endIgnoringInteractionEvents() //temp
                performSegue(withIdentifier: "Login_Segue", sender: nil)
            }
            
        }
        
    }
    
    
    @IBAction func About_Action(_ sender: Any) {
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
        performSegue(withIdentifier: "About_Segue", sender: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

