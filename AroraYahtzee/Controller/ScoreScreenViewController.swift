//
//  ScoreScreenViewController.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/14/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import UIKit

class ScoreScreenViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    //dice values
    var diceViewController = ViewController()
    var diceValue1 = 0
    var diceValue2 = 0
    var diceValue3 = 0
    var diceValue4 = 0
    var diceValue5 = 0
    
    
    var isSelectionMade : Bool = false
    
    var selectedIndex : Int = -1
    
    var rollNumber = 0
    
    var isMultiYahtzee = false
    var upperTotal = 0
    var bonus = 0
    var lowerTotal = 0
    var grandTotal = 0
    
    let scoreCardTableViewCell = ScoreCardTableViewCell()
    
    //title, value, isSelected, isCompleted, description
    var scoreCardArray : [ScoreLineModel] = []
    
    var valuesArray : [Int] = []
    
    let defaults = UserDefaults.standard
    
    //stored score values
    var sOnes = 0
    var sTwos = 0
    var sThrees = 0
    var sFours = 0
    var sFives = 0
    var sSixes = 0
    var sThreeOfAKind = 0
    var sFourOfAKind = 0
    var sFullHouse = 0
    var sSmallStraight = 0
    var sLargeStraight = 0
    var sYahtzee = 0
    var sChance = 0
    var sNumberOfYahtzees = 0
    
    //stored isCompleted bool values
    var sIsOnesComplete = false
    var sIsTwosComplete = false
    var sIsThreesComplete = false
    var sIsFoursComplete = false
    var sIsFivesComplete = false
    var sIsSixesComplete = false
    var sIsThreeOfAKindComplete = false
    var sIsFourOfAKindComplete = false
    var sIsFullHouseComplete = false
    var sIsSmallStraightComplete = false
    var sIsLargeStraightComplete = false
    var sIsYahtzeeComplete = false
    var sIsChanceComplete = false
    
    
    //current values
    
    var cOnes = 0
    var cTwos = 0
    var cThrees = 0
    var cFours = 0
    var cFives = 0
    var cSixes = 0
    var cThreeOfAKind = 0
    var cFourOfAKind = 0
    var cFullHouse = 0
    var cSmallStraight = 0
    var cLargeStraight = 0
    var cYahtzee = 0
    var cChance = 0
    var cNumberOfYahtzees = 0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //load previously recorded score data
        loadStoredScores()
        
        //check possible values of the current roll
        checkPossibleScores()
        
        tableView.register(UINib(nibName: "ScoreCardTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreCardTableViewCell")
        
        
    }
    
    func loadStoredScores(){
        
        //TODO: Load data and set it to stored variables. Stored variables are created already: ex: sOnes sFullHouse... and sIsOnesComplete etc
        
        if(defaults.bool(forKey: "isOnesComplete")){
            print("Load: ones complete")
            sIsOnesComplete = true
            
            let tOnes = defaults.integer(forKey: "onesValue")
            if(tOnes != 0){
                sOnes = tOnes
            }
        }
        
        if(defaults.bool(forKey: "isTwosComplete")){
            sIsTwosComplete = true
            
            let tTwos = defaults.integer(forKey: "twosValue")
            if(tTwos != 0){
                sTwos = tTwos
            }
        }
        
        if(defaults.bool(forKey: "isThreesComplete")){
            sIsThreesComplete = true
            
            let tThrees = defaults.integer(forKey: "threesValue")
            if(tThrees != 0){
                sThrees = tThrees
            }
        }
        
        if(defaults.bool(forKey: "isFoursComplete")){
            sIsFoursComplete = true
            
            let tFours = defaults.integer(forKey: "foursValue")
            if(tFours != 0){
                sFours = tFours
            }
        }
        
        if(defaults.bool(forKey: "isFivesComplete")){
            sIsFivesComplete = true
            
            let tFives = defaults.integer(forKey: "fivesValue")
            if(tFives != 0){
                sFives = tFives
            }
        }
        
        if(defaults.bool(forKey: "isSixesComplete")){
            sIsSixesComplete = true
            
            let tSixes = defaults.integer(forKey: "sixesValue")
            if(tSixes != 0){
                sSixes = tSixes
            }
        }
        
        if(defaults.bool(forKey: "isThreeOfAKindComplete")){
            sIsThreeOfAKindComplete = true
            
            let tThreeOfAKind = defaults.integer(forKey: "threeOfAKindValue")
            if(tThreeOfAKind != 0){
                sThreeOfAKind = tThreeOfAKind
            }
        }
        
        if(defaults.bool(forKey: "isFourOfAKindComplete")){
            sIsFourOfAKindComplete = true
            
            let tFourOfAKind = defaults.integer(forKey: "fourOfAKindValue")
            if(tFourOfAKind != 0){
                sFourOfAKind = tFourOfAKind
            }
        }
        
        if(defaults.bool(forKey: "isFullHouseComplete")){
            sIsFullHouseComplete = true
            
            let tFullHouse = defaults.integer(forKey: "fullHouseValue")
            if(tFullHouse != 0){
                sFullHouse = tFullHouse
            }
        }
        
        if(defaults.bool(forKey: "isSmallStraightComplete")){
            sIsSmallStraightComplete = true
            
            let tSmallStraight = defaults.integer(forKey: "smallStraightValue")
            if(tSmallStraight != 0){
                sSmallStraight = tSmallStraight
            }
        }
        
        if(defaults.bool(forKey: "isLargeStraightComplete")){
            sIsLargeStraightComplete = true
            
            let tLargeStraight = defaults.integer(forKey: "largeStraightValue")
            if(tLargeStraight != 0){
                sLargeStraight = tLargeStraight
            }
        }
        
        if(defaults.bool(forKey: "isYahtzeeComplete")){
            sIsYahtzeeComplete = true
            
            //yahtzee value (first)
            let tYahtzee = defaults.integer(forKey: "yahtzeeValue")
            if(tYahtzee != 0){
                sYahtzee = tYahtzee
            }
            
            
            //additional yahtzees
            let tNumberOfYahtzees = defaults.integer(forKey: "numberOfYahtzeesValue")
            if(tNumberOfYahtzees != 0){
                sNumberOfYahtzees = tNumberOfYahtzees
            }
        }
        
        if(defaults.bool(forKey: "isChanceComplete")){
            sIsChanceComplete = true
            
            let tChance = defaults.integer(forKey: "chanceValue")
            if(tChance != 0){
                sChance = tChance
            }
        }
        
        upperTotal = sOnes + sTwos + sThrees + sFours + sFives + sSixes
        
        lowerTotal = sThreeOfAKind + sFourOfAKind + sFullHouse + sSmallStraight + sLargeStraight + sYahtzee + sChance + (sNumberOfYahtzees * 100)
        
        if(upperTotal >= 63){
            bonus = 35
        }
        
        grandTotal = upperTotal + lowerTotal + bonus
        
        scoreLabel.text = "Score : \(grandTotal)"
        
        
        
        //TODO: Once data is set to the variables use those variables to update the ScoreLineModel array with value and isCompleted which are the second and fourth thing in the model. (unless UNNEEDED)
        scoreCardArray = [
        
            ScoreLineModel("Ones", sOnes, false, sIsOnesComplete, "description", false, false), //0
            ScoreLineModel("Twos", sTwos, false, sIsTwosComplete, "description" , false ,false), //1
            ScoreLineModel("Threes", sThrees, false, sIsThreesComplete, "description", false, false), //2
            ScoreLineModel("Fours", sFours, false, sIsFoursComplete, "description", false, false), //3
            ScoreLineModel("Fives", sFives, false, sIsFivesComplete, "description", false, false), //4
            ScoreLineModel("Sixes", sSixes, false, sIsSixesComplete, "description", false, false), //5
            ScoreLineModel("Upper Total", 0, false, false, "description", true, false), //6
            ScoreLineModel("Bonus", 0, false, false, "description", true, false), //7
            ScoreLineModel("3 of a Kind", sThreeOfAKind, false, sIsThreeOfAKindComplete, "description", false, false), //8
            ScoreLineModel("4 of a Kind", sFourOfAKind, false, sIsFourOfAKindComplete, "description", false, false), //9
            ScoreLineModel("Full House", sFullHouse, false, sIsFullHouseComplete, "description", false, false), //10
            ScoreLineModel("Small Straight", sSmallStraight, false, sIsSmallStraightComplete, "description", false, false), //11
            ScoreLineModel("Large Straight", sLargeStraight, false, sIsLargeStraightComplete, "description", false, false), //12
            ScoreLineModel("Yahtzee", sYahtzee, false, sIsYahtzeeComplete, "description", false, false), //13
            ScoreLineModel("Chance", sChance, false, sIsChanceComplete, "description", false, false), //14
            ScoreLineModel("Yahtzee Bonus", (sNumberOfYahtzees * 100), false, false, "description", true, false), //15 //TODO: update this with actual var for number of yahtzees
            ScoreLineModel("Lower Total", 0, false, false, "description", true, false), //16
            ScoreLineModel("Grand Total", 0, false, false, "description", true, false), //17
        
        ]
       
    }

    
    //use the dice roll values to check what the value of each score on the scorecard would be
    //YOU ARE HERE
    //TODO: All of these need to check if the category is completed before calculating. Started this...
    //TODO: Update the array with these values at the end
    //TODO: after values in array are updated, refresh tableview.
    //TODO: next step will be to set up persistance for the data
    func checkPossibleScores(){
        //dice rolls are passed using a prepare function in ViewController(main / roll screen)
        print("One: \(diceValue1) , Two: \(diceValue2) , Three: \(diceValue3) , Four: \(diceValue4) , Five: \(diceValue5)")
        
        //put the roll values in array and put them in order ascending numerical
        valuesArray = [diceValue1, diceValue2, diceValue3, diceValue4, diceValue5]
        valuesArray.sort()
        
        //COUNT EACH NUMBER
        var oneCounter = 0
        var twoCounter = 0
        var threeCounter = 0
        var fourCounter = 0
        var fiveCounter = 0
        var sixCounter = 0
        for value in valuesArray{
            if(value == 1){
                oneCounter = oneCounter + 1
            }
            if(value == 2){
                twoCounter = twoCounter + 1
            }
            if(value == 3){
                threeCounter = threeCounter + 1
            }
            if(value == 4){
                fourCounter = fourCounter + 1
            }
            if(value == 5){
                fiveCounter = fiveCounter + 1
            }
            if(value == 6){
                sixCounter = sixCounter + 1
            }
        }
        
        print("One Counter = \(oneCounter)")
        print("Two Counter = \(twoCounter)")
        print("Three Counter = \(threeCounter)")
        print("Four Counter = \(fourCounter)")
        print("Five Counter = \(fiveCounter)")
        print("Six Counter = \(sixCounter)")
        
        //ONES
        var onesScore = 0
        if(!scoreCardArray[0].isCompleted){
            for value in valuesArray{
                if(value == 1){
                    onesScore = onesScore + value
                }
            }
            
            print("Ones: \(onesScore)")
        }
        else {
            onesScore = sOnes
            print("sOnes: \(sOnes)")
        }
        
        
        //TWOS
        var twosScore = 0
        if(!scoreCardArray[1].isCompleted){
            for value in valuesArray{
                if(value == 2){
                    twosScore = twosScore + value
                }
            }
            print("Twos: \(twosScore)")
        } else {
            twosScore = sTwos
            print("sTwos: \(sTwos)")
        }
        
        //THREES
        var threesScore = 0
        if(!scoreCardArray[2].isCompleted){
            for value in valuesArray{
                if(value == 3){
                    threesScore = threesScore + value
                }
            }
            print("Threes: \(threesScore)")
        } else {
            threesScore = sThrees
            print("sThrees: \(sThrees)")
        }
        
        //FOURS
        var foursScore = 0
        if(!scoreCardArray[3].isCompleted){
            for value in valuesArray{
                if(value == 4){
                    foursScore = foursScore + value
                }
            }
            print("Fours : \(foursScore)")
        } else {
            foursScore = sFours
            print("sFours: \(sFours)")
        }
        
        //FIVES
        var fivesScore = 0
        if(!scoreCardArray[4].isCompleted){
            for value in valuesArray{
                if(value == 5){
                    fivesScore = fivesScore + value
                }
            }
            print("Fives : \(fivesScore)")
        } else {
            fivesScore = sFives
            print("sFives: \(sFives)")
        }
        
        
        //SIXES
        var sixesScore = 0
        if(!scoreCardArray[5].isCompleted){
            for value in valuesArray{
                if(value == 6){
                    sixesScore = sixesScore + value
                }
            }
            print("Sixes : \(sixesScore)")
        } else {
            sixesScore = sSixes
            print("sSixes: \(sSixes)")
        }
        
        //UPPER TOTAL
        upperTotal = sOnes + sTwos + sThrees + sFours + sFives + sSixes
        print("Upper Total : \(upperTotal)")
        
        
        //BONUS
        bonus = 0
        if(upperTotal >= 63){ bonus = 35 }
        print("Bonus : \(bonus)")
        
        
        //3 OF A KIND
        var threeOfAKindScore = 0
        if(!scoreCardArray[8].isCompleted){
            var isThreeOfKind = false
            if(oneCounter >= 3){
                isThreeOfKind = true
            }
            if(twoCounter >= 3){
                isThreeOfKind = true
            }
            if(threeCounter >= 3){
                isThreeOfKind = true
            }
            if(fourCounter >= 3){
                isThreeOfKind = true
            }
            if(fiveCounter >= 3){
                isThreeOfKind = true
            }
            if(sixCounter >= 3){
                isThreeOfKind = true
            }
            
            if(isThreeOfKind){
                threeOfAKindScore = diceValue1 + diceValue2 + diceValue3 + diceValue4 + diceValue5
            } else {
                threeOfAKindScore = 0
            }
            
            print("Three of a Kind: \(threeOfAKindScore)")
            
        } else {
            threeOfAKindScore = sThreeOfAKind
            print("sThree of a Kind: \(sThreeOfAKind)")
        }
        
        
        //4 OF A KIND
        var fourOfAKindScore = 0
        if(!scoreCardArray[9].isCompleted){
            var isFourOfKind = false
            if(oneCounter >= 4){
                isFourOfKind = true
            }
            if(twoCounter >= 4){
                isFourOfKind = true
            }
            if(threeCounter >= 4){
                isFourOfKind = true
            }
            if(fourCounter >= 4){
                isFourOfKind = true
            }
            if(fiveCounter >= 4){
                isFourOfKind = true
            }
            if(sixCounter >= 4){
                isFourOfKind = true
            }
            
            if(isFourOfKind){
                fourOfAKindScore = diceValue1 + diceValue2 + diceValue3 + diceValue4 + diceValue5
            } else {
                fourOfAKindScore = 0
            }
            
            print("Four of a Kind: \(fourOfAKindScore)")
            
        } else {
            fourOfAKindScore = sFourOfAKind
            print("sFour of a Kind: \(sFourOfAKind)")
        }
        
        //FULL HOUSE
        var fullHouseScore = 0
        if(!scoreCardArray[10].isCompleted){
            var isFullHouse = false
            var isPair = false
            var isTrio = false
            var theNumberThatHasAPair = 0
            var theNumberThatHasATrio = 0
            
            if(oneCounter == 2){
                isPair = true
                theNumberThatHasAPair = 1
            }
            if(twoCounter == 2){
                isPair = true
                theNumberThatHasAPair = 2
            }
            if(threeCounter == 2){
                isPair = true
                theNumberThatHasAPair = 3
            }
            if(fourCounter == 2){
                isPair = true
                theNumberThatHasAPair = 4
            }
            if(fiveCounter == 2){
                isPair = true
                theNumberThatHasAPair = 5
            }
            if(sixCounter == 2){
                isPair = true
                theNumberThatHasAPair = 6
            }
            
            if(oneCounter == 3){
                isTrio = true
                theNumberThatHasATrio = 1
            }
            if(twoCounter == 3){
                isTrio = true
                theNumberThatHasATrio = 2
            }
            if(threeCounter == 3){
                isTrio = true
                theNumberThatHasATrio = 3
            }
            if(fourCounter == 3){
                isTrio = true
                theNumberThatHasATrio = 4
            }
            if(fiveCounter == 3){
                isTrio = true
                theNumberThatHasATrio = 5
            }
            if(sixCounter == 3){
                isTrio = true
                theNumberThatHasATrio = 6
            }
            
            if(isPair && isTrio){
                if(theNumberThatHasAPair != theNumberThatHasATrio){
                    isFullHouse = true
                }
            }
            
            if(isFullHouse){
                fullHouseScore = 25
            }
            
            print("Full House: \(fullHouseScore)")
            
        } else {
            fullHouseScore = sFullHouse
            print("sFull House: \(sFullHouse)")
        }
        
        
        //SM STRAIGHT
        var smallStraightScore = 0
        if(!scoreCardArray[11].isCompleted){
            var isSmallStraight = false
            
            if(valuesArray.contains(1) && valuesArray.contains(2) && valuesArray.contains(3) && valuesArray.contains(4)){
                isSmallStraight = true
            }
            else if(valuesArray.contains(2) && valuesArray.contains(3) && valuesArray.contains(4) && valuesArray.contains(5)){
                isSmallStraight = true
            }
            else if(valuesArray.contains(3) && valuesArray.contains(4) && valuesArray.contains(5) && valuesArray.contains(6)){
                isSmallStraight = true
            }
            else {
                isSmallStraight = false
            }
            
            if(isSmallStraight){
                smallStraightScore = 30
            }
            
            print("Small Straight: \(smallStraightScore)")
            
        } else {
            smallStraightScore = sSmallStraight
            print("sSmall Stright: \(sSmallStraight)")
        }
        
        
        //LRG STRAIGHT
        var largeStraightScore = 0
        if(!scoreCardArray[12].isCompleted){
            var isLargeStraight = false
            
            if(valuesArray.contains(1) && valuesArray.contains(2) && valuesArray.contains(3) && valuesArray.contains(4) && valuesArray.contains(5)){
                isLargeStraight = true
            }
            else if(valuesArray.contains(2) && valuesArray.contains(3) && valuesArray.contains(4) && valuesArray.contains(5) && valuesArray.contains(6)){
                isLargeStraight = true
            }
            else {
                isLargeStraight = false
            }
            
            if(isLargeStraight){
                largeStraightScore = 40
            }
            
            print("Large Straight: \(largeStraightScore)")
            
        } else {
            largeStraightScore = sLargeStraight
            print("sLarge Straight: \(sLargeStraight)")
        }
        
        //YAHTZEE
        //TODO: note this should be checked even if it is completed (however if it is completed we will need to run the bonus yahtzee functionality to place a yahtzee in a different category
        var yahtzeeScore = 0
        var isYahtzee = false
        if(oneCounter >= 5){
            isYahtzee = true
        }
        if(twoCounter >= 5){
            isYahtzee = true
        }
        if(threeCounter >= 5){
            isYahtzee = true
        }
        if(fourCounter >= 5){
            isYahtzee = true
        }
        if(fiveCounter >= 5){
            isYahtzee = true
        }
        if(sixCounter >= 5){
            isYahtzee = true
        }
        
        if(isYahtzee){
            yahtzeeScore = 50
        }
        if(!scoreCardArray[13].isCompleted){
            
            print("Yahtzee: \(yahtzeeScore)")
            
        }
        //yahtzee is complete
         else {
             //but player has another yahtzee
             if(sYahtzee > 0){
                 if(isYahtzee){
                     isMultiYahtzee = true
                     print("is multi yahtzee = \(isMultiYahtzee)")
                     //show message to user telling them they have an additional yahtzee and they should select a place to put it
                     DispatchQueue.main.async {
                         let alert = UIAlertController(title: "Multiple Yahtzees!", message: "You have rolled another yahtzee! Select a category. That category will be set to completed and you will get points for another yahtzee instead.", preferredStyle: .alert)
                         let action = UIAlertAction(title: "OK", style:  .cancel, handler:  nil)
                         
                         alert.addAction(action)
                         
                         self.present(alert, animated: true)
                     }
                 }
             }
            yahtzeeScore = sYahtzee
            print("sYahtzee: \(sYahtzee)")
        }
        
        
        //CHANCE
        var chanceScore = 0
        if(!scoreCardArray[14].isCompleted){
        chanceScore = diceValue1 + diceValue2 + diceValue3 + diceValue4 + diceValue5
        
        print("Chance: \(chanceScore)")
        } else {
            chanceScore = sChance
            print("sChance: \(sChance)")
        }
        
        
        //LOWER TOTAL
        
        lowerTotal = sThreeOfAKind + sFourOfAKind + sFullHouse + sSmallStraight + sLargeStraight + sYahtzee + sChance + (sNumberOfYahtzees * 100)
        print("number of additional yahtzees = \(sNumberOfYahtzees)")
        print("Lower Total: \(lowerTotal)")
        
        //GRAND TOTAL
        
        grandTotal = upperTotal + bonus + lowerTotal
        
        print("Grand Total: \(grandTotal)")
        
        
        scoreCardArray = [
        
            ScoreLineModel("Ones", onesScore, false, sIsOnesComplete, "description", false, false), //0
            ScoreLineModel("Twos", twosScore, false, sIsTwosComplete, "description", false, false), //1
            ScoreLineModel("Threes", threesScore, false, sIsThreesComplete, "description", false, false), //2
            ScoreLineModel("Fours", foursScore, false, sIsFoursComplete, "description", false, false), //3
            ScoreLineModel("Fives", fivesScore, false, sIsFivesComplete, "description", false, false), //4
            ScoreLineModel("Sixes", sixesScore, false, sIsSixesComplete, "description", false, false), //5
            ScoreLineModel("Upper Total", upperTotal, false, false, "description", true, false), //6
            ScoreLineModel("Bonus", bonus, false, false, "description", true, false), //7
            ScoreLineModel("3 of a Kind", threeOfAKindScore, false, sIsThreeOfAKindComplete, "description", false, false), //8
            ScoreLineModel("4 of a Kind", fourOfAKindScore, false, sIsFourOfAKindComplete, "description", false, false), //9
            ScoreLineModel("Full House", fullHouseScore, false, sIsFullHouseComplete, "description", false, false), //10
            ScoreLineModel("Small Straight", smallStraightScore, false, sIsSmallStraightComplete, "description", false, false), //11
            ScoreLineModel("Large Straight", largeStraightScore, false, sIsLargeStraightComplete, "description", false, false), //12
            ScoreLineModel("Yahtzee", yahtzeeScore, false, sIsYahtzeeComplete, "description", false, false), //13
            ScoreLineModel("Chance", chanceScore, false, sIsChanceComplete, "description", false, false), //14
            ScoreLineModel("Yahtzee Bonus", (sNumberOfYahtzees * 100), false, false, "description", true, false), //15
            ScoreLineModel("Lower Total", lowerTotal, false, false, "description", true, false), //16
            ScoreLineModel("Grand Total", grandTotal, false, false, "description", true, false), //17
        
        ]
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCardTableViewCell", for: indexPath) as! ScoreCardTableViewCell
        
        cell.titleLabel.text = scoreCardArray[indexPath.row].title
        
        cell.valueLabel.text = String(scoreCardArray[indexPath.row].value)
        
        //give the user a visual que that they have selected something
        if(self.scoreCardArray[indexPath.row].isSelected){
            cell.selectButton.tintColor = UIColor.green
        } else {
        cell.selectButton.tintColor = UIColor.systemBlue
        }
        
        if(self.scoreCardArray[indexPath.row].isCompleted){
            cell.selectButton.isHidden = true
            cell.valueLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        } else {
            cell.selectButton.isHidden = false
            cell.valueLabel.font = UIFont.systemFont(ofSize: 17.0)
        }
        
        if(self.scoreCardArray[indexPath.row].isDerivative){
            cell.selectButton.isHidden = true
            cell.valueLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        }
        
        //toggle the selected item, store the index of it, and give user a visual que about what is selected
        cell.closure = {
            //give the user a visual que that they have selected something
            cell.selectButton.tintColor = UIColor.green
            
            //player has a normal roll that is not a multi yahtzee
            if(!self.isMultiYahtzee){
           
            //score update for unselect
            if(self.selectedIndex >= 0){
                //there is a previous selection... remove it from the totals before adding the new selection to the totals
                if(self.selectedIndex < 6){
                    self.upperTotal = self.upperTotal - self.scoreCardArray[self.selectedIndex].value
                } else {
                    self.lowerTotal = self.lowerTotal - self.scoreCardArray[self.selectedIndex].value
                }
            }
            
            //set variables to reflect that a selection was made, and what index it is
            self.isSelectionMade = true
            self.selectedIndex = indexPath.row
            
            
            // loop through the array and set the selected row
            var index = 0
            for score in self.scoreCardArray {
                
                //set everything to unselected
                if(score.isSelected){ score.isSelected = false }
                
                //set the current index to selected
                if(index == indexPath.row){ score.isSelected = true }
                
                index = index + 1
            }
            
            //update score based on selection
            if(indexPath.row < 6){
                self.upperTotal = self.upperTotal + self.scoreCardArray[indexPath.row].value
            } else {
                self.lowerTotal = self.lowerTotal + self.scoreCardArray[indexPath.row].value
            }
            
            print("after selection upper total = \(self.upperTotal)")
            print("after selection lower totla = \(self.lowerTotal)")
            
            if(self.upperTotal >= 63){
                self.bonus = 35
            } else {
                self.bonus = 0
            }
            
            self.grandTotal = self.upperTotal + self.lowerTotal + self.bonus
            
            self.scoreLabel.text = "Score : \(self.grandTotal)"
                
                self.scoreCardArray[6].value = self.upperTotal
                self.scoreCardArray[7].value = self.bonus
                self.scoreCardArray[16].value = self.lowerTotal
                self.scoreCardArray[17].value = self.grandTotal
                
                
            }
            //player has a multiyahtzee
            else {
                //score update for unselect
                if(self.selectedIndex >= 0){
                    //there is a previous selection... remove it from the totals before adding the new selection to the totals
                   self.lowerTotal = self.lowerTotal - 100
                }
                
                //set variables to reflect that a selection was made, and what index it is
                self.isSelectionMade = true
                self.selectedIndex = indexPath.row
                
                // loop through the array and set the selected row
                var index = 0
                for score in self.scoreCardArray {
                    
                    //set everything to unselected
                    if(score.isSelected){ score.isSelected = false }
                    
                    //set the current index to selected
                    if(index == indexPath.row){ score.isSelected = true }
                    
                    index = index + 1
                }
                
                //the value for the selected row should be set to 0
                
                self.scoreCardArray[indexPath.row].value = 0
                
                //the multi yahtzee score should go up by 50
                
                self.sNumberOfYahtzees = self.sNumberOfYahtzees + 1
                self.scoreCardArray[15].value = (self.sNumberOfYahtzees * 100)
                
                
                //the score totals should be updated
                self.lowerTotal = self.lowerTotal + 100
                self.grandTotal = self.upperTotal + self.lowerTotal + self.bonus
                
                self.scoreCardArray[16].value = self.lowerTotal
                self.scoreCardArray[17].value = self.grandTotal
                
                self.scoreLabel.text = "Score : \(self.grandTotal)"
            }
          
            //update the tableview to reflect the change
            tableView.reloadData()
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.scoreCardArray.count
    }
    
    func record(){
        //record the score in the selected slot
        //close the scorecard
        if(isSelectionMade){
            
            //TODO: evaluate and most likely remove because we are not using this class for persistant storage
//            let newTitle = scoreCardArray[selectedIndex].title
//            let newValue = scoreCardArray[selectedIndex].value
//            let newIsSelected = scoreCardArray[selectedIndex].isSelected
//            let newIsCompleted = true
//            let newDescription = scoreCardArray[selectedIndex].description
//
//            let newSLM = ScoreLineModel(newTitle, newValue, newIsSelected, newIsCompleted, newDescription)
//
//            scoreCardArray.remove(at: selectedIndex)
//            scoreCardArray.insert(newSLM, at: selectedIndex)
//            tableView.reloadData()
            
            
            //check what is selected and then save to persistant storage
            //using this format : defaults.set("value", forKey: "key")
            
            //values and iscomplete
            if(scoreCardArray[0].isSelected){
                defaults.set(scoreCardArray[0].value, forKey: "onesValue")
                defaults.set(true, forKey: "isOnesComplete")
            }
            if(scoreCardArray[1].isSelected){
                defaults.set(scoreCardArray[1].value, forKey: "twosValue")
                defaults.set(true, forKey: "isTwosComplete")
            }
            if(scoreCardArray[2].isSelected){
                defaults.set(scoreCardArray[2].value, forKey: "threesValue")
                defaults.set(true, forKey: "isThreesComplete")
            }
            if(scoreCardArray[3].isSelected){
                defaults.set(scoreCardArray[3].value, forKey: "foursValue")
                defaults.set(true, forKey: "isFoursComplete")
            }
            if(scoreCardArray[4].isSelected){
                defaults.set(scoreCardArray[4].value, forKey: "fivesValue")
                defaults.set(true, forKey: "isFivesComplete")
            }
            if(scoreCardArray[5].isSelected){
                defaults.set(scoreCardArray[5].value, forKey: "sixesValue")
                defaults.set(true, forKey: "isSixesComplete")
            }
            if(scoreCardArray[8].isSelected){
                defaults.set(scoreCardArray[8].value, forKey: "threeOfAKindValue")
                defaults.set(true, forKey: "isThreeOfAKindComplete")
            }
            if(scoreCardArray[9].isSelected){
                defaults.set(scoreCardArray[9].value, forKey: "fourOfAKindValue")
                defaults.set(true, forKey: "isFourOfAKindComplete")
            }
            if(scoreCardArray[10].isSelected){
                defaults.set(scoreCardArray[10].value, forKey: "fullHouseValue")
                defaults.set(true, forKey: "isFullHouseComplete")
            }
            if(scoreCardArray[11].isSelected){
                defaults.set(scoreCardArray[11].value, forKey: "smallStraightValue")
                defaults.set(true, forKey: "isSmallStraightComplete")
            }
            if(scoreCardArray[12].isSelected){
                defaults.set(scoreCardArray[12].value, forKey: "largeStraightValue")
                defaults.set(true, forKey: "isLargeStraightComplete")
            }
            if(scoreCardArray[13].isSelected){
                defaults.set(scoreCardArray[13].value, forKey: "yahtzeeValue")
                defaults.set(true, forKey: "isYahtzeeComplete")
            }
            if(scoreCardArray[14].isSelected){
                defaults.set(scoreCardArray[14].value, forKey: "chanceValue")
                defaults.set(true, forKey: "isChanceComplete")
            }
            
            if(isMultiYahtzee){
                defaults.set(sNumberOfYahtzees, forKey: "numberOfYahtzeesValue")
            }
            
            print("score card: score = \(grandTotal)")
            defaults.set(grandTotal, forKey: "score")
            
            
            
            checkEndGame()
            
        } else{
            
            //tell the user to select something
            
            let alert = UIAlertController(title: "Category Empty", message: "Select the category where you want to record your roll.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style:  .cancel, handler:  nil)
            
            alert.addAction(action)
            
            present(alert, animated: true)
        }
    }
    
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        //check if the roll number is  < 3... if it is then the user can use the cancel button because they don't have to select anything yet
        
        if(rollNumber < 3){
            
            //close this screen
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
            
        } else {
            
            //user must select a category to record their score because they have rolled 3 times
            //tell the user to select something
            let alert = UIAlertController(title: "Record Your Score", message: "You have rolled 3 times. You must record your roll.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style:  .cancel, handler:  nil)
            
            alert.addAction(action)
            
            present(alert, animated: true)
            
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //record value of selection to persistent or tell user to make selection
        record()
        
        //reset the number of rolls to zero
        guard let rollVC = segue.destination as? ViewController else { return }
        rollVC.rollNumber = 0
    }
    
    
    func checkEndGame(){
        
        var isEnd = false
        var categoryCompleteCounter = 0
        
        for score in scoreCardArray{
            
            if(score.isCompleted || score.isSelected){
                categoryCompleteCounter = categoryCompleteCounter + 1
            }
            
        }
        
        if(categoryCompleteCounter >= 13){
            isEnd = true
        }
        
        if(isEnd){
            //store the score
            print("score card: score = \(grandTotal)")
            defaults.set(grandTotal, forKey: "score")
            
            //segue to high score screen
            let highScoreVC = storyboard?.instantiateViewController(withIdentifier: "HighScoreScreen") as! HighScoreViewController
            highScoreVC.modalPresentationStyle = .fullScreen
            present(highScoreVC, animated:true, completion:nil)
        }
        
        
        
    }
    

}
