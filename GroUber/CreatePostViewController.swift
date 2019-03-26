//
//  CreatePostViewController.swift
//  GroUber
//
//  Created by Paul Lim on 3/26/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit
import Firebase
class CreatePostViewController: UIViewController {
    @IBOutlet weak var pickUpTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var rideDate: UIDatePicker!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var capacityStepper: UIStepper!
    @IBOutlet weak var postButton: UIButton!
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func capacityUpdate(_ sender: Any) {
        
    }
    
    @IBAction func createGroupRide(_ sender: Any) {
        // check that all fields are filled
        if (String(pickUpTextField.text!) == "" ||
            String(destinationTextField.text!) == "") {
            self.createAlert(title: "ERROR", message: "Please make sure to fill out all fields")
        }
        // check if rideDate is in the future
        if (Date() > rideDate.date) {
            self.createAlert(title: "ERROR", message: "Date of Group Ride must be in the future")
        }
        // create a reference to the database
        
    }
    
}
