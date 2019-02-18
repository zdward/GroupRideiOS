//
//  HubViewController.swift
//  GroUber
//
//  Created by alex chuckas on 2/5/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class HubViewController: UITableViewController, UISearchResultsUpdating {

    
    //variables
    var refresher: UIRefreshControl!
    var Settings_Table: UITableView!
    var Cover_View: UIView!
    var menu_open = false
    var can_touch_settings = true
    var location:CGPoint = CGPoint(x: 0, y: 0)
    var menu_offset: CGFloat = 0
    
    //for the hub downloads
    var users = [String: String]() //to store friended users
    var messages = [String]()
    var usernames = [String]()
    //var imageFiles = [PFFile]() //will be for watever database returns
    var displayed_posts = 5 //will set this to the number of posts to be displayed in the feed
    
    //for searching
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults : [(title: String, image: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //for the button
        let title_button = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        //title_button.backgroundColor = .green
        title_button.setTitleColor(UIColor.black, for: .normal)
        title_button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 20)
        title_button.setTitle("GroupRide", for: .normal)
        title_button.addTarget(self, action: #selector(scrollToTop), for: .touchUpInside)
        self.navigationController?.topViewController?.navigationItem.titleView = title_button //add to the view

        
        //for the refresher buffer thingy
        refresher = UIRefreshControl()
        //refresher.attributedTitle = NSAttributedString(string: "Pull to refresh") // AttributedString(string: "Pull to refresh") is now NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refresher)
        
        Cover_View = CoverView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        Cover_View.backgroundColor = UIColor.black
        Cover_View.alpha = 0
        self.tabBarController!.view.addSubview(Cover_View)
        
        
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        
        // Place the search bar in the table view's header.
        self.tableView.tableHeaderView = searchController.searchBar
        
        // Set the content offset to the height of the search bar's height
        // to hide it when the view is first presented.
        self.tableView.contentOffset = CGPoint(x: 0, y: searchController.searchBar.frame.height)
        self.searchController.searchBar.barTintColor = UIColor.white
        for view in self.searchController.searchBar.subviews {
            for subview in view.subviews {
                 if let textField = subview as? UITextField {
                    //for the background
                    textField.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
                    //use the code below if you want to change the color of placeholder
                }
            }
        }
        
        
        Settings_Table = CustomTable(frame: CGRect(x: -300, y: 0, width: 300, height: UIScreen.main.bounds.height))
        Settings_Table.dataSource = self
        Settings_Table.delegate = self
        //Settings_Table.backgroundColor = UIColor.gray
        Settings_Table.separatorColor = UIColor.clear
        self.tabBarController!.view.addSubview(Settings_Table)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle_tap))
        tap.cancelsTouchesInView = false
        self.Cover_View.addGestureRecognizer(tap)
        
        //pan the screen - will control table view movement
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handle_pan))
        pan.cancelsTouchesInView = false
        self.tabBarController!.view.addGestureRecognizer(pan)
    }
    
    // ---- refresh the main hub ----
    @objc func refresh() {
        self.tableView.reloadData()
        self.refresher.endRefreshing()
    }

    // MARK: - Table view data source

    // ---- Table Setup ----
    //choose number of allowed cells (default)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == Settings_Table {
            return 6
        }
        //add code to return a specific number of posts and if scroll down can load more
        if displayed_posts >= 25 {
            return 25
        }
        return displayed_posts //if the user can only see less than 25 posts, can change
    }
    
    //create the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == Settings_Table {
            let settings_cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "settings_cell")
            if indexPath.row == 0 {
                settings_cell.textLabel?.text = "Edit Profile"
            } else if indexPath.row == 1 {
                settings_cell.textLabel?.text = "Notifications"
            } else if indexPath.row == 2 {
                settings_cell.textLabel?.text = "Privacy Settings"
            } else if indexPath.row == 3 {
                settings_cell.textLabel?.text = "Security Settings"
            } else if indexPath.row == 4 {
                settings_cell.textLabel?.text = "Add Friends"
            } else if indexPath.row == 5 {
                settings_cell.textLabel?.text = "Log Out"
            }
            return settings_cell
        }
        
        //add code below for the feed
        let hub_cell = tableView.dequeueReusableCell(withIdentifier: "post_cell", for: indexPath) as! FeedCell
        hub_cell.ProfileName.text = "Zachary Ward"
        //hub_cell.ProfileImage.image = UIImage(named: <#T##String#>) //will be getting image from the database
        hub_cell.MessageLabel.text = "Looking for a GroupRide to Crossgates at 4:00pm on 3/4/19"
        hub_cell.selectionStyle = .none
        return hub_cell
    }
    
    //cell functionality
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == Settings_Table {
            if indexPath.row == 0 {
                //configure action when tap cell 1
                
            } else if indexPath.row == 1 {
                //configure action when tap cell 2
                
            } else if indexPath.row == 2 {
                //configure action when tap cell 3
                
            } else if indexPath.row == 3 {
                //configure action when tap cell 4
                
            } else if indexPath.row == 4 {
                //configure action when tap cell 5
                
            } else if indexPath.row == 5 {
                //configure action when tap cell 6 - logout
                let alert = UIAlertController(title: "Log out of (profile name)?", message: "", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: { (action) in
                    //complete logout action from database/userdefaults saved login
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    //deals with loading more cells when reach the bottom
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                //add the spinner to the footer of the table
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                
                self.tableView.tableFooterView = spinner
                self.tableView.tableFooterView?.isHidden = false
                
                tableView.beginUpdates()
                //in this area, query for more posts to add to the table
                //tableView.insertRows(at: [IndexPath(row: yourArray.count-1, section: 0)], with: .automatic)
                tableView.endUpdates()
                
                //self.tableView.tableFooterView?.isHidden = true //call this after finishing update on table
            }
        }
    }
    
    // ---- Gesture Work ----
    //for the coverview, with grayout, if touching and the menu open close the menu
    @objc func handle_tap(gesture: UITapGestureRecognizer) {
        location = gesture.location(in: gesture.view)
        print(location.x)
        if menu_open && location.x > Settings_Table.bounds.width {
            settings_close()
        }
    }
    
    //deals with pulling the settings menu out from the side. this gesture is bar of the main view controller
    @objc func handle_pan(gesture: UIPanGestureRecognizer) {
        //essentially same as touchesbegan
        if(gesture.state == .began) {
            location = gesture.location(in: tableView)
            
            //if within 1.8 of screen bounds we can open the settings menu
            if location.x <= UIScreen.main.bounds.width / 8 {
                can_touch_settings = true
                Settings_Table.center.x = location.x - Settings_Table.bounds.width / 2
            }
            menu_offset = Settings_Table.center.x - location.x
        //gesture changed and touching settings allow, essentially touchesmoved
        } else if (gesture.state == .changed) && can_touch_settings {
            //velocity
            //print("uerm")
            location = gesture.location(in: tableView)
            let velocity = gesture.velocity(in: self.view)
            if velocity.x > 1000 && !menu_open{
                settings_open()
                can_touch_settings = false
                return
            } else if velocity.x < -1000 && menu_open {
                settings_close()
                can_touch_settings = false
                return
            } else {
                //actual panning
                Settings_Table.center.x = location.x + menu_offset
                if Settings_Table.center.x < -150 {
                    Settings_Table.center.x = -150
                    can_touch_settings = false
                } else if Settings_Table.center.x > 150 {
                    Settings_Table.center.x = 150
                }
                Cover_View.alpha = (0.6 / Settings_Table.bounds.width) * (Settings_Table.center.x + Settings_Table.bounds.width / 2)
            }
        }
        //touches ended equivalent, deals with final state of menu so it does not sit half open/close
        if (gesture.state == .ended) {
            if !menu_open {
                if Settings_Table.center.x >= 100 {
                    settings_open()
                } else {
                    settings_close()
                }
            } else {
                if Settings_Table.center.x <= -100 {
                    settings_close()
                } else {
                    settings_open()
                }
            }
        }
    }
    
    // ---- settings table animations ----
    func settings_open() {
        UITableView.animate(withDuration: 0.3) {
            self.Settings_Table.center.x = 150
            self.updateFocusIfNeeded()
        }
        UIView.animate(withDuration: 0.3) {
            self.Cover_View.alpha = 0.6
            self.updateFocusIfNeeded()
        }
        menu_open = true
        can_touch_settings = true
    }
    
    func settings_close() {
        UITableView.animate(withDuration: 0.3) {
            self.Settings_Table.center.x = -150
            self.updateFocusIfNeeded()
        }
        UIView.animate(withDuration: 0.3) {
            self.Cover_View.alpha = 0
            self.updateFocusIfNeeded()
        }
        menu_open = false
        can_touch_settings = false
    }
    
    // ---- SEARCH BAR ----
    func filterContent(for searchText: String) {
        // Update the searchResults array with matches
        // in our entries based on the title value.
        /*searchResults = entries.filter({ (title: String, image: String) -> Bool in
            let match = title.range(of: searchText, options: .caseInsensitive)
            // Return the tuple if the range contains a match.
            return match != nil
        })*/
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // If the search bar contains text, filter our data with the string
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            // Reload the table view with the search result data.
            self.tableView.reloadData()
        }
    }
    
    //---- scroll to top button ----
    @objc func scrollToTop(sender: UIButton!) {
        print("Button tapped")
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
    }
}
