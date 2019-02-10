//
//  CreateAccountViewController.swift
//  GroUber
//
//  Created by Farukh Saidmuratov on 2/9/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userName_field: UITextField!
    @IBOutlet weak var rcsID_field: UITextField!
    @IBOutlet weak var fName_field: UITextField!
    @IBOutlet weak var lName_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var confirmPassword_field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Allow "password" and "confirm password" text field to interact with view
        password_field.delegate = self
        confirmPassword_field.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func CreateAccount_Action_Button(_ sender: Any) {
        if userName_field.text == "" || password_field.text == "" ||  rcsID_field.text == "" || fName_field.text == "" || lName_field.text == "" || confirmPassword_field.text == "" {
            createAlert(title: "Please fill in all fields", message: "")
        }
        else if password_field.text != confirmPassword_field.text {
            createAlert(title: "Please ensure that both passwords match", message: "")
            confirmPassword_field.resignFirstResponder()
        }
        else {
            createAlert(title: "Confirmation Sent", message: "Please check your email")
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
