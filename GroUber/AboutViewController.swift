//
//  SettingsViewController.swift
//  GroUber
//
//  Created by Zachary Ward on 1/26/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBAction func Back_Main(_ sender: Any) {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        
        self.activityIndicator.stopAnimating() //temp
        UIApplication.shared.endIgnoringInteractionEvents() //temp
        performSegue(withIdentifier: "Main_Segue", sender: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

