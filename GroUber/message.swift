//
//  message.swift
//  Pods
//
//  Created by Alexis Joseph on 2/22/19.
//

import Foundation
import Firebase

class Joke {
    private var _messageRef: Firebase!
    
    private var _messageKey: String!
    private var _messageText: String!
    private var _messageVotes: Int!
    private var _username: String!
    
    var messageKey: String {
        return _messageKey
    }
    
    var messageText: String {
        return _messageText
    }
    
    var messageVotes: Int {
        return _messageVotes
    }
    
    var username: String {
        return _username
    }
    
    // Initialize the new Message
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._messageKey = key
        
        // Within the Message, or Key, the following properties are children
        
        if let votes = dictionary["votes"] as? Int {
            self._messageVotes = votes
        }
        
        if let message = dictionary["messageText"] as? String {
            self._messageText = joke
        }
        
        if let user = dictionary["author"] as? String {
            self._username = user
        } else {
            self._username = ""
        }
        
        // The above properties are assigned to their key.
        
        self._messageRef = DataService.dataService.MESSAGE_REF.childByAppendingPath(self._messageKey)
    }
    
    func addSubtractVote(addVote: Bool) {
        
        if addVote {
            _messageVotes = _messageVotes + 1
        } else {
            _messageVotes = _messageVotes - 1
        }
        
        // Save the new vote total.
        
        _messageRef.childByAppendingPath("votes").setValue(_messageVotes)
        
    }
}
