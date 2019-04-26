//
//  PostViewController.swift
//  GroUber
//
//  Created by alex chuckas on 3/25/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PostViewController: UIViewController, UITextViewDelegate {
    //WILL NEED TO FIX CONSTRAINTS LATER
    @IBOutlet weak var post_text: UITextView!
    
    //for entering time and day to meet
    @IBOutlet weak var pm_am_picker: UISegmentedControl!
    @IBOutlet weak var time_field: UITextField!
    @IBOutlet weak var date_field: UITextField!
    
    
    let count_label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.post_text.delegate = self
        self.post_text.isScrollEnabled = false
        post_text.textContainer.maximumNumberOfLines = 6
        post_text.textContainer.lineBreakMode = .byTruncatingTail
        
        post_text.text = "Placeholder"
        post_text.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        
        count_label.center = CGPoint(x: 8 * post_text.frame.size.width / 10, y: 9 * post_text.frame.size.height / 10)
        count_label.textAlignment = NSTextAlignment.center
        count_label.textColor = UIColor.gray
        
        
        //the size of the placeholder text
        if post_text.text.count == 11 {
            count_label.text = "0/500"
        } else {
            count_label.text = String(post_text.text.count) + "/500"
        }
        self.post_text.addSubview(count_label)
        

    }
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func createPostID() {
        let userID = Auth.auth().currentUser?.uid
        let userDB =  Database.database().reference().child("Users").child(userID!)
        
        userDB.observeSingleEvent(of: .value, with: { (snapshot) in
            // get user's data
            let snapshotValue = snapshot.value as! [String : Any]
            let userPosts : [String] = snapshotValue["posts"] as! [String]
            
            // create the postID (basically count the user's # of posts and assign next available #)
            // check if this is the user's first post
            var postID = -1
            if userPosts.isEmpty {
                postID = 1
            } else{
                postID = userPosts.count + 1
            }
            self.addPostToDB(userID: userID!, postID: String(postID))
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func addPostToDB(userID : String, postID : String) {
        let postsDB = Database.database().reference().child("Posts")
        let postData : [String : Any] = [
            "ownerUID" : userID,
            "time" : time_field.text!,
            "isAM" : pm_am_picker.selectedSegmentIndex == 0 ? true : false,
            "date" : date_field.text!,
            "description" : self.post_text.text!,
            // list of users who will share the ride, owner is automatically added
            "groupRiders" : [userID]
        ]
        
        // unique key for this post
        let postID = userID + ":" + postID
        // Send data to DB
        postsDB.child(postID).setValue(postData) { (error, reference) in
            if error != nil {
                print(error!)
            } else {
                print("Successfully stored post in DB")
            }
        }
    }
    
    //function for posting to server
    @IBAction func post_action(_ sender: Any) {
        //send information to database to be added to the post page
        let dateFormatterGet = DateFormatter()
        
        //for actual date
        dateFormatterGet.dateFormat = "mm/dd/yyyy"
        let date = date_field.text
        let am_pm_state = pm_am_picker.selectedSegmentIndex
        var am_pm = ""
        if am_pm_state == 0 {
            am_pm = "am"
        } else {
            am_pm = "pm"
        }
        let message = post_text.text
        
        //get current date fields since we cant go to date before this
        let cur_date = Date()
        let calendar = Calendar.current
        let cur_hour = calendar.component(.hour, from: cur_date)
        let cur_minutes = calendar.component(.minute, from: cur_date)
        let cur_day = calendar.component(.day, from: cur_date)
        let cur_year = calendar.component(.year, from: cur_date)
        let cur_month = calendar.component(.month, from: cur_date)
    
        if dateFormatterGet.date(from: date!) != nil  {
            let date_arr = date!.characters.split(separator: "/").map(String.init)
            let day = Int(date_arr[1])!
            let month = Int(date_arr[0])!
            let year = Int(date_arr[2])!
            
            if day >= cur_day && month >= cur_month && year >= cur_year {
                //for time
                dateFormatterGet.dateFormat = "hh:mm"
                
                let time = time_field.text
                let time_arr = time!.characters.split(separator: ":").map(String.init)
                let hour = Int(time_arr[0])!
                let minute = Int(time_arr[1])!

                if dateFormatterGet.date(from: time!) != nil {
                    if hour >= cur_hour && minute >= cur_minutes + 10 {
                        if !(hour > 12 || minute > 59 || minute < 0 || hour < 1) {
                            //---------- HERE IS WHERE WE WOULD POST TO THE SERVER ----------
                            //can send variables month, day, year, minute, hour, am_pm, message to server
                            // create unique post ID for this post and add to the database
                            SVProgressHUD.show()
                            self.createPostID()
                            SVProgressHUD.dismiss()
                            
                            
                        } else {
                            createAlert(title: "Invalid Time", message: "Hour or minute not correct")
                            time_field.text = ""
                        }
                    } else {
                        createAlert(title: "Invalid Time", message: "Please enter a time at least 10 minutes in the future")
                        time_field.text = ""
                    }
                } else {
                    createAlert(title: "Invalid Time Format", message: "Enter in format hh:mm")
                    time_field.text = ""
                }
            } else {
                createAlert(title: "Invalid Date", message: "Please enter a date that exists in the future")
                date_field.text = ""
            }
            
        } else {
            createAlert(title: "Invalid Date Format", message: "Enter in format mm/dd/yyyy")
            date_field.text = ""
        }
        
        
    }
    
    //expandable field
    /*
    func textViewDidChange(_ textView: UITextView) {
        
        let textViewFixedWidth: CGFloat = self.post_text.frame.size.width
        let newSize: CGSize = self.post_text.sizeThatFits(CGSize(width: textViewFixedWidth, height: CGFloat(MAXFLOAT)))
        var newFrame: CGRect = self.post_text.frame
        
        var textViewYPosition = self.post_text.frame.origin.y
        var heightDifference = self.post_text.frame.height - newSize.height
        
        if (abs(heightDifference) > 20) {
            newFrame.size = CGSize(width: fmax(newSize.width,textViewFixedWidth), height: newSize.height)
            newFrame.offsetBy(dx: 0.0, dy: 0)
        }
        self.post_text.frame = newFrame
        
    }*/
    
    //allow for return key exit out of textfield
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //textField code
        
        textField.resignFirstResponder()  //if desired
        //performAction()
        return true
    }
    
    //placeholder stuff
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
    //display live count
    func textViewDidChange(_ textView: UITextView) {
        
        count_label.text =  String(textView.text.count) + "/500" // Set value of the label
    }
    
    //set character max
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //stop editting when return key pressed
        if text == "\n" {
            textView.endEditing(true)
        }
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 500    // 10 Limit Value
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
