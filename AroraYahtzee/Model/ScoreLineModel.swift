//
//  ScoreLineModel.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/14/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import UIKit

class ScoreLineModel {
    
    //The things we may want to display on any line of the scorecard. Not all will be needed on each line.
    
    //name of the category or the line
    var title : String
    
    //the value of this category (either stored or based on current roll)
    var value : Int
    
    //the player has currently selected this category
    var isSelected : Bool
    
    //the player has already filled out this category
    var isCompleted : Bool
    
    //when the player hovers over the category ( or some other UI way) display this to explain the category
    var description : String
    
    //this is for the lines that are sums or bonus
    var isDerivative : Bool
    
    //this line has been selected for a multiyahtzee
    var isMultiYahtzeeSelection : Bool
    
    init(_ title: String, _ value: Int, _ isSelected: Bool, _ isCompleted : Bool, _ description : String, _ isDerivative: Bool, _ isMultiYahtzeeSelection: Bool){
        
        self.title = title
        self.value = value
        self.isSelected = isSelected
        self.isCompleted = isCompleted
        self.description = description
        self.isDerivative = isDerivative
        self.isMultiYahtzeeSelection = isMultiYahtzeeSelection
        
    }
    
}
