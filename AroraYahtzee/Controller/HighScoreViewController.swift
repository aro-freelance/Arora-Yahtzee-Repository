//
//  HighScoreViewController.swift
//  Dicee-iOS13
//
//  Created by Mandy on 6/13/22.
//  Copyright © 2022 London App Brewery. All rights reserved.
//

import Foundation
import UIKit

class HighScoreViewController : UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var newScore = 0
    var isNewHighScore = false
    var numberNewScoreIsHigherThan = 0
    
    var highScoreArray : [SavedScoreModel] = []
    
    var nameEntered = "x"
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "HighScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "HighScoreTableViewCell")
        
        getHighScores()
        
        //if player is coming from a game, check if they have a new high score
        checkIfNewScore()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreTableViewCell", for: indexPath) as! HighScoreTableViewCell
        
        cell.nameLabel.text = highScoreArray[indexPath.row].playerName
        
        cell.scoreLabel.text = String(highScoreArray[indexPath.row].score)
    
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.highScoreArray.count
    }
    
    
    
    func getHighScores(){
        
        highScoreArray = [
        
            SavedScoreModel(defaults.integer(forKey: "highscore1") , defaults.string(forKey: "highscore1name") ?? ""),
            SavedScoreModel(defaults.integer(forKey: "highscore2") , defaults.string(forKey: "highscore2name") ?? ""),
            SavedScoreModel(defaults.integer(forKey: "highscore3") , defaults.string(forKey: "highscore3name") ?? ""),
            SavedScoreModel(defaults.integer(forKey: "highscore4") , defaults.string(forKey: "highscore4name") ?? ""),
            SavedScoreModel(defaults.integer(forKey: "highscore5") , defaults.string(forKey: "highscore5name") ?? ""),
            SavedScoreModel(defaults.integer(forKey: "highscore6") , defaults.string(forKey: "highscore6name") ?? ""),
            SavedScoreModel(defaults.integer(forKey: "highscore7") , defaults.string(forKey: "highscore7name") ?? ""),
            SavedScoreModel(defaults.integer(forKey: "highscore8") , defaults.string(forKey: "highscore8name") ?? ""),
            SavedScoreModel(defaults.integer(forKey: "highscore9") , defaults.string(forKey: "highscore9name") ?? ""),
            SavedScoreModel(defaults.integer(forKey: "highscore10") , defaults.string(forKey: "highscore10name") ?? "")
        
        ]
        
        
        
        
        
        //TEST ARRAY
        //if there is no score in the top slot, then there shouldn't be any high scores. so fill with the default array
        if(highScoreArray[0].score == 0){
            highScoreArray = [
                SavedScoreModel(0 , "Player"),
                SavedScoreModel(0 , "Player"),
                SavedScoreModel(0 , "Player"),
                SavedScoreModel(0 , "Player"),
                SavedScoreModel(0 , "Player"),
                SavedScoreModel(0 , "Player"),
                SavedScoreModel(0 , "Player"),
                SavedScoreModel(0 , "Player"),
                SavedScoreModel(0 , "Player"),
                SavedScoreModel(0 , "Player"),
            
            ]
            
            saveNewHighScores()
        }
         
        
        //TODO: Sort?
        
        //display this array to tableview
        tableView.reloadData()
    }
    
    
    func checkIfNewScore(){
        
        newScore = defaults.integer(forKey: "score")
        
        print("new score : \(newScore)")
        
        if(newScore > 0){
            
            //there is a new high score. show the UI for it
            compareToHighScores()
            
        }
        
    }
    
    func showNewHighScoreUI(){
        //TODO: show UI Stuff
        //edit text for name
        //labels explaining what is up and showing the score
        //save button
        let alert = UIAlertController(title: "Score: \(newScore)", message: "New High Score! Enter your name.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Player Name"
        }

        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            
            self.nameEntered = textField.text ?? ""
            
            //remove the lowest score
            self.highScoreArray.remove(at: 9)

            //insert into array
            self.highScoreArray.insert(SavedScoreModel(self.newScore, self.nameEntered), at: (10 - self.numberNewScoreIsHigherThan))
            
            //save to high scores persistant data
            self.saveNewHighScores()

            //display array to tableview
            self.tableView.reloadData()
           
        }))
        
        self.present(alert, animated: true, completion: nil)
       
    }
    
    func showNotHighScoreUI(){
        
        //TODO: display a pop up showing the user their score and saying it is not a high score
        
        let alert = UIAlertController(title: "Score: \(newScore)", message: "Game Over. You did not get a new high score.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style:  .cancel, handler:  nil)
        
        alert.addAction(action)
        
        present(alert, animated: true)
        
        
    }
    
    func compareToHighScores(){
        
        //check if the new score is higher than any of the stored highscores
        for highScore in highScoreArray{
            
            if(newScore > highScore.score){
                isNewHighScore = true
                numberNewScoreIsHigherThan = numberNewScoreIsHigherThan + 1
            }
        }
        
        DispatchQueue.main.async {
            if(self.isNewHighScore){
                self.showNewHighScoreUI()
            } else {
                self.showNotHighScoreUI()
            }
        }
        
    }
    
    func saveNewHighScores(){
        
        defaults.set(highScoreArray[0].score, forKey: "highscore1")
        defaults.set(highScoreArray[0].playerName, forKey: "highscore1name")
        
        defaults.set(highScoreArray[1].score, forKey: "highscore2")
        defaults.set(highScoreArray[1].playerName, forKey: "highscore2name")
        
        defaults.set(highScoreArray[2].score, forKey: "highscore3")
        defaults.set(highScoreArray[2].playerName, forKey: "highscore3name")
        
        defaults.set(highScoreArray[3].score, forKey: "highscore4")
        defaults.set(highScoreArray[3].playerName, forKey: "highscore4name")
        
        defaults.set(highScoreArray[4].score, forKey: "highscore5")
        defaults.set(highScoreArray[4].playerName, forKey: "highscore5name")
        
        defaults.set(highScoreArray[5].score, forKey: "highscore6")
        defaults.set(highScoreArray[5].playerName, forKey: "highscore6name")
        
        defaults.set(highScoreArray[6].score, forKey: "highscore7")
        defaults.set(highScoreArray[6].playerName, forKey: "highscore7name")
        
        defaults.set(highScoreArray[7].score, forKey: "highscore8")
        defaults.set(highScoreArray[7].playerName, forKey: "highscore8name")
        
        defaults.set(highScoreArray[8].score, forKey: "highscore9")
        defaults.set(highScoreArray[8].playerName, forKey: "highscore9name")
        
        defaults.set(highScoreArray[9].score, forKey: "highscore10")
        defaults.set(highScoreArray[9].playerName, forKey: "highscore10name")
        
    }
    
}
