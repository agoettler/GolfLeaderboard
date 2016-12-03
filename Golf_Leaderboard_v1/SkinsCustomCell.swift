//
//  SkinsCustomCell.swift
//  Golf_Leaderboard_v1
//
//  Created by Adam Fairchild Gary on 11/30/16.
//  Copyright © 2016 Group 3. All rights reserved.
//

import UIKit

class SkinsCustomCell: UITableViewCell {

    
    @IBOutlet weak var holeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
