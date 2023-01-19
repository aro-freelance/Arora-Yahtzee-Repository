//
//  TitleViewController.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/13/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import UIKit
import AVFAudio

class TitleViewController : UIViewController {
    
    let defaults = UserDefaults.standard
    
    var isMuted = false
    
    var greetingsSoundPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        
        resetGameData()
        
        isMuted = defaults.bool(forKey: "titleScreenMute")
        
        let greetingsSound = Bundle.main.path(forResource: "greetingsToDadCrop", ofType: "mp3")
        do {
            greetingsSoundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: greetingsSound!))
        } catch{
            print(error)
        }
        
        if(!isMuted){
            greetingsSoundPlayer.play()
        }
        
    }
    
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        //do not delete
    }
    
    
    @IBAction func optionsButtonPressed(_ sender: UIButton) {
        //do not delete
    }
    
    
    @IBAction func highScoreButtonPressed(_ sender: UIButton) {
        //do not delete
    }
    
    
    func resetGameData(){
        
        defaults.removeObject(forKey: "onesValue")
        defaults.removeObject(forKey: "twosValue")
        defaults.removeObject(forKey: "threesValue")
        defaults.removeObject(forKey: "foursValue")
        defaults.removeObject(forKey: "fivesValue")
        defaults.removeObject(forKey: "sixesValue")
        defaults.removeObject(forKey: "threeOfAKindValue")
        defaults.removeObject(forKey: "fourOfAKindValue")
        defaults.removeObject(forKey: "fullHouseValue")
        defaults.removeObject(forKey: "smallStraightValue")
        defaults.removeObject(forKey: "largeStraightValue")
        defaults.removeObject(forKey: "yahtzeeValue")
        defaults.removeObject(forKey: "chanceValue")
        defaults.removeObject(forKey: "numberOfYahtzeesValue")
        
        defaults.removeObject(forKey: "isOnesComplete")
        defaults.removeObject(forKey: "isTwosComplete")
        defaults.removeObject(forKey: "isThreesComplete")
        defaults.removeObject(forKey: "isFoursComplete")
        defaults.removeObject(forKey: "isFivesComplete")
        defaults.removeObject(forKey: "isSixesComplete")
        defaults.removeObject(forKey: "isThreeOfAKindComplete")
        defaults.removeObject(forKey: "isFourOfAKindComplete")
        defaults.removeObject(forKey: "isFullHouseComplete")
        defaults.removeObject(forKey: "isSmallStraightComplete")
        defaults.removeObject(forKey: "isLargeStraightComplete")
        defaults.removeObject(forKey: "isYahtzeeComplete")
        defaults.removeObject(forKey: "isChanceComplete")
        defaults.removeObject(forKey: "score")
        
        
        
    }
    
}
