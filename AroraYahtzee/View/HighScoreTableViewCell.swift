//
//  HighScoreTableViewCell.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/18/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {

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
