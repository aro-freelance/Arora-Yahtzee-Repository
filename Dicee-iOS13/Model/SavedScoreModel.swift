//
//  SavedScoreModel.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/13/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation

//TODO: build this for real with initializers
class SavedScoreModel{
    
    //this is for saving a player's score
    
    var score : Int = 0
    
    var playerName : String = ""
    
    init(_ score : Int, _ playerName : String){
        
        self.score = score
        self.playerName = playerName
        
    }
    
    
    
}
