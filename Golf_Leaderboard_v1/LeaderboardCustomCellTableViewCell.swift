//
//  LeaderboardCustomCellTableViewCell.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/8/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class LeaderboardCustomCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var thruLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
