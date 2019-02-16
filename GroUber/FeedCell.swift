//
//  FeedCell.swift
//  GroUber
//
//  Created by alex chuckas on 2/8/19.
//  Copyright © 2019 Zachary Ward. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var ProfileName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
