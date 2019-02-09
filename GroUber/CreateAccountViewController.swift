//
//  CreateAccountViewController.swift
//  GroUber
//
//  Created by Farukh Saidmuratov on 2/9/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var username_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    @IBOutlet weak var confirm_password_field: UITextField!
    @IBOutlet weak var rcsID_field: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showAlert() {
        print("Twelve pounds of used q-tips have now been shipped to your house.")
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
