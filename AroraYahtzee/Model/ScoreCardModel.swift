//
//  ScoreCardModel.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/13/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation

//TODO: set this up with initializers. calculate the totals.

class ScoreCardModel{
    
    var ones : Int = 0
    var twos : Int = 0
    var threes : Int = 0
    var fours : Int = 0
    var fives : Int = 0
    var sixes : Int = 0
    
    //the sum of ones, twos etc
    var upperTotal : Int = 0
    
    var bonus : Int = 35
    var isQualifiedForBonus : Bool = false
    
    var threeOfKindValue : Int = 0
    var isThreeOfKind : Bool = false
    
    var fourOfKindValue : Int = 0
    var isFourOfKind : Bool = false
    
    var fullHouseValue : Int = 25
    var isFullHouse : Bool = false
    
    var smStraightValue : Int = 30
    var isSmStraight : Bool = false
    
    var lrgStraightValue : Int = 40
    var isLrgStraight : Bool = false
    
    var yahtzeeValue : Int = 50
    var isYahtzee : Bool = false
    
    var chanceValue : Int = 0
    
    //if the player gets more than one yahtzee they can mark off another thing on the score card and get 50 points for a bonus yahtzee
    var yahtzeeCounter : Int = 0
    
    //sum of lower half of score card
    var lowerTotal : Int = 0
    
    var totalScore : Int = 0
    
    
}
