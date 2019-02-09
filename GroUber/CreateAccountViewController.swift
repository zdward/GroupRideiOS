//
//  CreateAccountViewController.swift
//  GroUber
//
//  Created by Farukh Saidmuratov on 2/9/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var rcsID: UITextField!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func CreateAccount_Button_Action(_ sender: UIButton) {
        if userName.text == "" || password.text == "" ||  rcsID.text == "" || fName.text == "" || lName.text == "" || confirmPassword.text == "" {
            createAlert(title: "Please fill in all fields", message: "")
        }
        else if password.text != confirmPassword.text {
            createAlert(title: "Please ensure that passwords match", message: "")
        }
        else {
            createAlert(title: "Email Sent!", message: "")
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
