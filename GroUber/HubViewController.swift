//
//  HubViewController.swift
//  GroUber
//
//  Created by alex chuckas on 2/5/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class HubViewController: UITableViewController {

    //variables
    var refresher: UIRefreshControl!
    var Settings_Table: UITableView!
    var Cover_View: UIView!
    var menu_open = false
    var can_touch_settings = true
    var location:CGPoint = CGPoint(x: 0, y: 0)
    var menu_offset: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //for the refresher buffer thingy
        refresher = UIRefreshControl()
        //refresher.attributedTitle = NSAttributedString(string: "Pull to refresh") // AttributedString(string: "Pull to refresh") is now NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refresher)
        
        Cover_View = CoverView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        Cover_View.backgroundColor = UIColor.black
        Cover_View.alpha = 0
        self.tabBarController!.view.addSubview(Cover_View)
        
        Settings_Table = CustomTable(frame: CGRect(x: -300, y: 0, width: 300, height: UIScreen.main.bounds.height))
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "settings_cell")
        cell.textLabel?.text = "fuck this shit"
        return cell
    }
    
    // ---- Gesture Work ----
    @objc func handle_tap(gesture: UITapGestureRecognizer) {
        location = gesture.location(in: view)
        print(location.x)
        if menu_open && location.x > Settings_Table.bounds.width {
            settings_close()
        }
    }
    
    @objc func handle_pan(gesture: UIPanGestureRecognizer) {
        //let touch = gesture.location(in: tableView)
        //print(touch)
        //menu_offset = Settings_Table.center.x - gesture.location(in: tableView).x
        //print(menu_offset)
        if(gesture.state == .began) {
            location = gesture.location(in: tableView)
            
            if location.x <= UIScreen.main.bounds.width / 8 {
                can_touch_settings = true
            }
            menu_offset = Settings_Table.center.x - location.x
            print(menu_offset)
        } else if (gesture.state == .changed) && can_touch_settings {
            //velocity
            //print("uerm")
            location = gesture.location(in: tableView)
            let velocity = gesture.velocity(in: self.view)
            if velocity.x > 1000 && !menu_open{
                settings_open()
                return
            } else if velocity.x < -1000 && menu_open {
                settings_close()
                return
            }
            
            //actual panning
            Settings_Table.center.x = location.x + menu_offset
            //print(Settings_Table.center.x)
            
            //print(Settings_Table.center.x)
            
            if Settings_Table.center.x < -150 {
                Settings_Table.center.x = -150
                can_touch_settings = false
            } else if Settings_Table.center.x > 150 {
                Settings_Table.center.x = 150
            }
            
            Cover_View.alpha = (0.6 / Settings_Table.bounds.width) * (Settings_Table.center.x + Settings_Table.bounds.width / 2)
            
        }
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
    
    /*
    // ---- touch functions ----
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        location = touch.location(in: tableView)
        print("\n---\n")
        print(location)
        
        if location.x <= UIScreen.main.bounds.width / 8 {
            can_touch_settings = true
        }
        
        menu_offset = Settings_Table.center.x - location.x
        
    }*/
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        location = touch.location(in: self.tableView)
        //print(location.x)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
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
    
    func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = hitTest(point, with: event)
        if hitView == Cover_View {
            return nil
        }
        return hitView
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
