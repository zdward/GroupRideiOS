//
//  ViewController.swift
//  GroUber
//
//  Created by Zachary Ward on 1/17/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    
    @IBOutlet weak var username_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    
    var activityIndicator = UIActivityIndicatorView()
    var signup_mode = true; //WILL SAVE THIS IN USERDEFAULTS LATER, saved pass and username feature, maybe attempt autologin
    
    /*
     * Description: diplays an alert to the viewcontroller with a title & a message
     *
     * @param  a short title, a specified reason/message
     * @return none
     * @author Alex Chuckas
     */
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //The login function
    @IBAction func Login(_ sender: Any) {
        // checks if there is text in both the rcsID_field and password_field
        if String(username_field.text!) == "" || String(password_field.text!) == "" {
            self.createAlert(title: "ERROR", message: "Please make sure to fill out all fields")
            return
        }
        // extract info from email text-field
        let email = String(username_field.text!) + "@rpi.edu"
        // extract info from password text-field
        let password = String(password_field.text!)
        // Firebase's sign-in function
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error != nil{
                print("Error logging in user: \(error!.localizedDescription)");
                self.createAlert(title: "ERROR", message: "Invalid Username/Password!")
            } else {
                // check if user's account is verified
                if (user?.user.isEmailVerified)! {
                    // user's email is verified; sign in success
                    self.performSegue(withIdentifier: "Login_Segue", sender: nil)
                } else {
                    self.createAlert(title: "Verification Required", message: "Please verify your account by clicking on the account verification link in your email")
                }
            }
        }
    }
    
    //Takes you to the about page
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
    @IBAction func register(_ sender: Any) {
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
        DispatchQueue.main.async{
            self.performSegue(withIdentifier: "create_account", sender: nil)
        }
    }
    //Takes you to the register page
    
    //added so this button at least does something. We don't want any dead buttons.
    @IBAction func forgot_password(_ sender: Any) {
        createAlert(title: "ERROR", message: "We haven't implemented this feature yet. For now, register a new account!")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

