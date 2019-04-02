//
//  PostViewController.swift
//  GroUber
//
//  Created by alex chuckas on 3/25/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITextViewDelegate {
    
    //WILL NEED TO FIX CONSTRAINTS LATER
    @IBOutlet weak var post_text: UITextView!
    
    @IBOutlet weak var date_pick: UIDatePicker!
    
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
        
        self.date_pick.minimumDate = Date()

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
