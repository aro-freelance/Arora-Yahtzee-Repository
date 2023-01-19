//
//  OptionsViewController.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/13/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import UIKit

class OptionsViewController : UIViewController {
    
    
    @IBOutlet weak var soundEffectMuteButton: UIButton!
    
    @IBOutlet weak var titleScreenMuteButton: UIButton!
    let defaults = UserDefaults.standard
    
    var isSoundEffectMuted = false
    
    var isTitleScreenMuted = false
    
    override func viewDidLoad() {
        
        isSoundEffectMuted = defaults.bool(forKey: "soundEffectMute")
        
        isTitleScreenMuted = defaults.bool(forKey: "titleScreenMute")
        
        if(isSoundEffectMuted){
            soundEffectMuteButton.tintColor = UIColor.red
            soundEffectMuteButton.setTitle("Unmute Sound Effects", for: .normal)
        }
        else{
            soundEffectMuteButton.tintColor = UIColor.systemGreen
            soundEffectMuteButton.setTitle("Mute Sound Effects", for: .normal)
        }
        
        if(isTitleScreenMuted){
            titleScreenMuteButton.tintColor = UIColor.red
            titleScreenMuteButton.setTitle("Unmute Title Screen", for: .normal)
        }
        else{
            titleScreenMuteButton.tintColor = UIColor.systemGreen
            titleScreenMuteButton.setTitle("Mute Title Screen", for: .normal)
        }
    }
    
    @IBAction func titleScreenMuteButtonPressed(_ sender: UIButton) {
        
        isTitleScreenMuted.toggle()
        
        if(isTitleScreenMuted){
            titleScreenMuteButton.tintColor = UIColor.red
            titleScreenMuteButton.setTitle("Unmute Title Screen", for: .normal)
        }
        else{
            titleScreenMuteButton.tintColor = UIColor.systemGreen
            titleScreenMuteButton.setTitle("Mute Title Screen", for: .normal)
        }
        
        defaults.set(isTitleScreenMuted, forKey: "titleScreenMute")
        
        
    }
    @IBAction func soundEffectButtonPressed(_ sender: UIButton) {
        
        
        isSoundEffectMuted.toggle()
        
        if(isSoundEffectMuted){
            soundEffectMuteButton.tintColor = UIColor.red
            soundEffectMuteButton.setTitle("Unmute Sound Effects", for: .normal)
        }
        else{
            soundEffectMuteButton.tintColor = UIColor.systemGreen
            soundEffectMuteButton.setTitle("Mute Sound Effects", for: .normal)
        }
        
        defaults.set(isSoundEffectMuted, forKey: "soundEffectMute")
        
    }
    
    
    @IBAction func resetHighScoresButtonPressed(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Reset High Scores?", message: "All high scores will be permanently erased", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("High Score Reset Completed")
            self.resetScores()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("High Score Reset Cancelled")
        }))

        present(alert, animated: true, completion: nil)
        
        
    }
    
    func resetScores(){
        defaults.set(0, forKey: "highscore1")
        defaults.set("player", forKey: "highscore1name")
        
        defaults.set(0, forKey: "highscore2")
        defaults.set("player", forKey: "highscore2name")
        
        defaults.set(0, forKey: "highscore3")
        defaults.set("player", forKey: "highscore3name")
        
        defaults.set(0, forKey: "highscore4")
        defaults.set("player", forKey: "highscore4name")
        
        defaults.set(0, forKey: "highscore5")
        defaults.set("player", forKey: "highscore5name")
        
        defaults.set(0, forKey: "highscore6")
        defaults.set("player", forKey: "highscore6name")
        
        defaults.set(0, forKey: "highscore7")
        defaults.set("player", forKey: "highscore7name")
        
        defaults.set(0, forKey: "highscore8")
        defaults.set("player", forKey: "highscore8name")
        
        defaults.set(0, forKey: "highscore9")
        defaults.set("player", forKey: "highscore9name")
        
        defaults.set(0, forKey: "highscore10")
        defaults.set("player", forKey: "highscore10name")
    }
    
    
}
