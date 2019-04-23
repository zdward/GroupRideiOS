//
//  ProfileViewController.swift
//  GroUber
//
//  Created by alex chuckas on 4/22/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class ProfileViewController: UITabBarController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var post_view: UITableView! //cells in table view show all posts sorted by most recent (cell show 2 lines of text at most, click it to go to new view controller with post where you can reply
    @IBOutlet weak var name_label: UILabel! //meant for profile name
    
    var profile_name = "Zachary Ward" //we be data taken from the database ultimately
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get the profile name from the web here and place as title and name label
        name_label.text = profile_name
        self.title = profile_name
        
        post_view.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ADD IN: code to send to the post view controller goes here
    }
    
    //ADD IN: should put in
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profile_cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "profile_cell")
        return profile_cell
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
