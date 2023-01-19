//
//  ScorecardViewController.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/13/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import UIKit

class ScorecardViewController : UIViewController {
    
    
    var isSelectionMade = false
    
    @IBOutlet weak var onesView: UIStackView!
    
    
    override func viewDidLoad() {
        
       
        
    }
    
    
    
    @IBAction func recordButtonPressed(_ sender: UIButton) {
        
        //TODO: record the score in the selected slot
        
        //close the scorecard
        
        if(isSelectionMade){
            navigationController?.popViewController(animated: true)

            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
}
