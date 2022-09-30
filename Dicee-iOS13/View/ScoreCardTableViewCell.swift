//
//  ScoreCardTableViewCell.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/14/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import UIKit

class ScoreCardTableViewCell: UITableViewCell {
    
    var closure: (()->())?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var selectButton: UIButton!
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        //this allows us to add functionality to this button in the UITableDelegate (ScoreScreenViewController)
        closure?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
