//
//  FeedCell.swift
//  GroUber
//
//  Created by alex chuckas on 2/8/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var totalVotesLabel: UILabel!
    @IBOutlet weak var thumbVoteImage: UIImageView!
    
    var message: Message!
    var voteRef: Firebase!
    
    func configureCell(message: Message) {
        self.message = message
        
        // Set the labels and textView.
        
        self.messageText.text = message.messageText
        self.totalVotesLabel.text = "Total Votes: \(message.messageVotes)"
        self.usernameLabel.text = message.username
        
        // Set "votes" as a child of the current user in Firebase and save the message's key in votes as a boolean.
        
        voteRef = DataService.dataService.CURRENT_USER_REF.childByAppendingPath("votes").childByAppendingPath(message.jokeKey)
        
        // observeSingleEventOfType() listens for the thumb to be tapped, by any user, on any device.
        
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            // Set the thumb image.
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                
                // Current user hasn't voted for the message... yet.
                
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
            } else {
                
                // Current user voted for the message!
                
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
            }
        })
    }
    
    func voteTapped(sender: UITapGestureRecognizer) {
        
        // observeSingleEventOfType listens for a tap by the current user.
        
        voteRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
                
                // addSubtractVote(), in message.swift, handles the vote.
                
                self.message.addSubtractVote(true)
                
                // setValue saves the vote as true for the current user.
                // voteRef is a reference to the user's "votes" path.
                
                self.voteRef.setValue(true)
            } else {
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
                self.message.addSubtractVote(false)
                self.voteRef.removeValue()
            }
            
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UITapGestureRecognizer is set programatically.
        
        let tap = UITapGestureRecognizer(target: self, action: "voteTapped:")
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.userInteractionEnabled = true
    }

    /*@IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var ProfileName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    } */

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
