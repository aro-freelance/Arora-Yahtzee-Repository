
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //link UI element using the storyboard assistant and dragging while holding control
   
    @IBOutlet weak var diceButton1: UIButton!
    
    @IBOutlet weak var diceButton2: UIButton!
    
    @IBOutlet weak var diceButton3: UIButton!
    
    @IBOutlet weak var diceButton4: UIButton!
    
    @IBOutlet weak var diceButton5: UIButton!
    
    @IBOutlet weak var scoreCardButton: UIButton!
    
    @IBOutlet weak var selectedDiceImageView1: UIImageView!
    
    @IBOutlet weak var selectedDiceImageView2: UIImageView!
    
    @IBOutlet weak var selectedDiceImageView3: UIImageView!
    
    @IBOutlet weak var selectedDiceImageView4: UIImageView!
    
    @IBOutlet weak var selectedDiceImageView5: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var isSelectedDice1 = false
    var isSelectedDice2 = false
    var isSelectedDice3 = false
    var isSelectedDice4 = false
    var isSelectedDice5 = false
    
    
    
    //array of images
    var diceArray = [UIImage(named: "DiceOne"), UIImage(named: "DiceTwo"), UIImage(named: "DiceThree"), UIImage(named: "DiceFour"), UIImage(named: "DiceFive"), UIImage(named: "DiceSix")]
    
    var selectedButtonArray : [UIButton] = []
    
    var selectedValuesArray : [Int] = []
    
    var diceNumberOne = 0
    var diceNumberTwo = 0
    var diceNumberThree = 0
    var diceNumberFour = 0
    var diceNumberFive = 0
    
    
    var rollNumber = 0
    
    var score = 0
    
    let defaults = UserDefaults.standard
    
    var rollSFXPlayer = AVAudioPlayer()
    var yahtzeeSFXPlayer = AVAudioPlayer()
    
    var musicPlayer = AVAudioPlayer()
    var isMuted = false
    
    override func viewDidLoad() {
        
        print("Roll Number : \(rollNumber)")
        
        
        if(rollNumber == 0){
            diceButton1.isHidden = true
            diceButton2.isHidden = true
            diceButton3.isHidden = true
            diceButton4.isHidden = true
            diceButton5.isHidden = true
            scoreCardButton.isHidden = true
        }
        
        diceButton1.setTitle("", for: .normal)
        diceButton1.setTitle("", for: .selected)
        diceButton1.setTitle("", for: .focused)
        
        diceButton2.setTitle("", for: .normal)
        diceButton2.setTitle("", for: .selected)
        diceButton2.setTitle("", for: .focused)
        
        diceButton3.setTitle("", for: .normal)
        diceButton3.setTitle("", for: .selected)
        diceButton3.setTitle("", for: .focused)
        
        diceButton4.setTitle("", for: .normal)
        diceButton4.setTitle("", for: .selected)
        diceButton4.setTitle("", for: .focused)
        
        diceButton5.setTitle("", for: .normal)
        diceButton5.setTitle("", for: .selected)
        diceButton5.setTitle("", for: .focused)
        
        
        diceButton1.tag = 1
        diceButton2.tag = 2
        diceButton3.tag = 3
        diceButton4.tag = 4
        diceButton5.tag = 5
        
        diceButton1.isEnabled = false
        diceButton2.isEnabled = false
        diceButton3.isEnabled = false
        diceButton4.isEnabled = false
        diceButton5.isEnabled = false
        
        selectedDiceImageView1.isHidden = true
        selectedDiceImageView2.isHidden = true
        selectedDiceImageView3.isHidden = true
        selectedDiceImageView4.isHidden = true
        selectedDiceImageView5.isHidden = true
        
        updateScore()
        
        //TODO: possibly record more and setup a randomizer
        //TODO: also make a yahtzee sound?
        //TODO: make a bg music sound
        
        //roll sound initialize
        let rollSound = Bundle.main.path(forResource: "dice4", ofType: "mp3")
        do {
            rollSFXPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: rollSound!))
        } catch{
            print(error)
        }
        
        //yahtzee sound initialize
        let yahtzeeSound = Bundle.main.path(forResource: "yahtzee1crop", ofType: "mp3")
        do {
            yahtzeeSFXPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: yahtzeeSound!))
        } catch{
            print(error)
        }
        
        isMuted = defaults.bool(forKey: "soundEffectMute")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("roll view will appear")
        updateScore()
    
    }
    
    
    
    func updateScore(){
        score = defaults.integer(forKey: "score")
        scoreLabel.text = "Score : \(score)"
        print("roll view : score = \(score)")
    }
    
    
    @IBAction func diceButtonSelected(_ sender: UIButton) {
        
        sender.titleLabel?.text = nil
        
        let selectedDiceTag = sender.tag
        var n = 0
        
        //get the number of the selected button and toggle that it is selected
        switch selectedDiceTag{
            
        case diceButton1.tag:
            isSelectedDice1.toggle()
            n = 1
        case diceButton2.tag:
            isSelectedDice2.toggle()
            n = 2
        case diceButton3.tag:
            isSelectedDice3.toggle()
            n = 3
        case diceButton4.tag:
            isSelectedDice4.toggle()
            n = 4
        case diceButton5.tag:
            isSelectedDice5.toggle()
            n = 5
        default: print("dice button error A")
            
        }
        
        //use the selected button number to append arrays with that button and its dice value
        switch n{
        
        case 1:
            if(isSelectedDice1){
                //TODO add visual que that it is selected.. repeat for each
                
                diceButton1.backgroundColor = UIColor.black
                
                if(!selectedButtonArray.contains(diceButton1)){
                    selectedButtonArray.append(diceButton1)
                    selectedValuesArray.append(diceNumberOne)
                }
            } else {
                //TODO remove visual que that it is selected... repeat for each
                //if the dice button is being unselected remove it from array for buttons and values
                
                diceButton1.backgroundColor = UIColor.clear
                
                let buttonIndex = selectedButtonArray.firstIndex(of: diceButton1)
                if(buttonIndex != nil){
                    selectedButtonArray.remove(at: buttonIndex!)
                }
                let valueIndex = selectedValuesArray.firstIndex(of: diceNumberOne)
                if(valueIndex != nil){
                    selectedValuesArray.remove(at: valueIndex!)
                }
                
            }
            
        case 2:
            if(isSelectedDice2){
                diceButton2.backgroundColor = UIColor.black
                
                if(!selectedButtonArray.contains(diceButton2)){
                    selectedButtonArray.append(diceButton2)
                    selectedValuesArray.append(diceNumberTwo)
                }
            } else {
                diceButton2.backgroundColor = UIColor.clear
                
                //if the dice button is being unselected remove it from array for buttons and values
                let buttonIndex = selectedButtonArray.firstIndex(of: diceButton2)
                if(buttonIndex != nil){
                    selectedButtonArray.remove(at: buttonIndex!)
                }
                let valueIndex = selectedValuesArray.firstIndex(of: diceNumberTwo)
                if(valueIndex != nil){
                    selectedValuesArray.remove(at: valueIndex!)
                }
                
            }
            
        case 3:
            if(isSelectedDice3){
                diceButton3.backgroundColor = UIColor.black
                
                if(!selectedButtonArray.contains(diceButton3)){
                    selectedButtonArray.append(diceButton3)
                    selectedValuesArray.append(diceNumberThree)
                }
            } else {
                diceButton3.backgroundColor = UIColor.clear
                
                //if the dice button is being unselected remove it from array for buttons and values
                let buttonIndex = selectedButtonArray.firstIndex(of: diceButton3)
                if(buttonIndex != nil){
                    selectedButtonArray.remove(at: buttonIndex!)
                }
                let valueIndex = selectedValuesArray.firstIndex(of: diceNumberThree)
                if(valueIndex != nil){
                    selectedValuesArray.remove(at: valueIndex!)
                }
                
            }
            
        case 4:
            if(isSelectedDice4){
                diceButton4.backgroundColor = UIColor.black
                
                if(!selectedButtonArray.contains(diceButton4)){
                    selectedButtonArray.append(diceButton4)
                    selectedValuesArray.append(diceNumberFour)
                }
            } else {
                diceButton4.backgroundColor = UIColor.clear
                
                //if the dice button is being unselected remove it from array for buttons and values
                let buttonIndex = selectedButtonArray.firstIndex(of: diceButton4)
                if(buttonIndex != nil){
                    selectedButtonArray.remove(at: buttonIndex!)
                }
                let valueIndex = selectedValuesArray.firstIndex(of: diceNumberFour)
                if(valueIndex != nil){
                    selectedValuesArray.remove(at: valueIndex!)
                }
                
            }
            
        case 5:
            diceButton5.backgroundColor = UIColor.black
            
            if(isSelectedDice5){
                if(!selectedButtonArray.contains(diceButton5)){
                    selectedButtonArray.append(diceButton5)
                    selectedValuesArray.append(diceNumberFive)
                }
            } else {
                diceButton5.backgroundColor = UIColor.clear
                
                //if the dice button is being unselected remove it from array for buttons and values
                let buttonIndex = selectedButtonArray.firstIndex(of: diceButton5)
                if(buttonIndex != nil){
                    selectedButtonArray.remove(at: buttonIndex!)
                }
                let valueIndex = selectedValuesArray.firstIndex(of: diceNumberFive)
                if(valueIndex != nil){
                    selectedValuesArray.remove(at: valueIndex!)
                }
                
            }
            
            
        default: print("dice button error B")
            
        }
        
        var boxNumber = 1
        
        /*
        selectedDiceImageView1.image = UIImage(systemName: "square")
        selectedDiceImageView2.image = UIImage(systemName: "square")
        selectedDiceImageView3.image = UIImage(systemName: "square")
        selectedDiceImageView4.image = UIImage(systemName: "square")
        selectedDiceImageView5.image = UIImage(systemName: "square")*/
        
        
        selectedDiceImageView1.isHidden = true
        selectedDiceImageView2.isHidden = true
        selectedDiceImageView3.isHidden = true
        selectedDiceImageView4.isHidden = true
        selectedDiceImageView5.isHidden = true
        
        
        //show the selected dice in a row below the rolled dice (this is disabled because it is a bit large and clunky. changing the apperance of the roll dice would be better.
        /*
        for button in selectedButtonArray{
            print("button tag : \(button.tag)")
            
            var box : UIImageView
            
            switch boxNumber{
            case 1: box = selectedDiceImageView1
            case 2: box = selectedDiceImageView2
            case 3: box = selectedDiceImageView3
            case 4: box = selectedDiceImageView4
            case 5: box = selectedDiceImageView5
            default: box = selectedDiceImageView1
            }
            
            box.isHidden = false
            box.image = button.imageView?.image
            
            //TODO make the images in the bottom look different
            
            
            boxNumber = boxNumber + 1
            
        }*/
        
//        for value in selectedValuesArray{
//            print("n : \(value)")
//        }
        
        
    }
    
    
    
    
    //on click
    //link button with control drag, but set to connection = Action, event = touch up inside, type = UIButton
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
       
        
        
        
        diceButton1.isHidden = false
        diceButton2.isHidden = false
        diceButton3.isHidden = false
        diceButton4.isHidden = false
        diceButton5.isHidden = false
        scoreCardButton.isHidden = false
        
        diceButton1.isEnabled = true
        diceButton2.isEnabled = true
        diceButton3.isEnabled = true
        diceButton4.isEnabled = true
        diceButton5.isEnabled = true
        
        sender.isEnabled = false
        
        rollNumber = rollNumber + 1
        
        if(rollNumber < 4){
            
            roll()
        }
        else{
            //TODO: Open Scorecard
            print("TODO segue to scorecard")
            let alert = UIAlertController(title: "Record Your Score", message: "You have rolled 3 times. You must record your roll.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style:  .cancel, handler:  nil)
            
            alert.addAction(action)
            
            present(alert, animated: true)
            
        }
        
        sender.isEnabled = true
           
    }
    
    func roll(){
        
        if(!isMuted){
            rollSFXPlayer.play()
        } else {
            print("roll sound while muted")
        }
        
        //random number from 0 to less than the capacity of the array (to avoid out of bounds)
        
        //change the image view to the image in the array at the random position
        
        if(!isSelectedDice1){
            diceNumberOne = 1 + Int.random(in: 0..<diceArray.capacity)
            diceButton1.setImage(diceArray[diceNumberOne - 1], for: .normal)
            diceButton1.setImage(diceArray[diceNumberOne - 1], for: .selected)
            diceButton1.setImage(diceArray[diceNumberOne - 1], for: .focused)
        }
        
        if(!isSelectedDice2){
            diceNumberTwo = 1 + Int.random(in: 0..<diceArray.capacity)
            diceButton2.setImage(diceArray[diceNumberTwo - 1], for: .normal)
            diceButton2.setImage(diceArray[diceNumberTwo - 1], for: .selected)
            diceButton2.setImage(diceArray[diceNumberTwo - 1], for: .focused)
        }
        
        if(!isSelectedDice3){
            diceNumberThree = 1 + Int.random(in: 0..<diceArray.capacity)
            diceButton3.setImage(diceArray[diceNumberThree - 1], for: .normal)
            diceButton3.setImage(diceArray[diceNumberThree - 1], for: .selected)
            diceButton3.setImage(diceArray[diceNumberThree - 1], for: .focused)
        }
        
        if(!isSelectedDice4){
            diceNumberFour = 1 + Int.random(in: 0..<diceArray.capacity)
            diceButton4.setImage(diceArray[diceNumberFour - 1], for: .normal)
            diceButton4.setImage(diceArray[diceNumberFour - 1], for: .selected)
            diceButton4.setImage(diceArray[diceNumberFour - 1], for: .focused)
        }
        
        if(!isSelectedDice5){
            diceNumberFive = 1 + Int.random(in: 0..<diceArray.capacity)
            diceButton5.setImage(diceArray[diceNumberFive - 1], for: .normal)
            diceButton5.setImage(diceArray[diceNumberFive - 1], for: .selected)
            diceButton5.setImage(diceArray[diceNumberFive - 1], for: .focused)
        }
        
        if(!isMuted){
            //play yahtzee sound after the roll sound
            let secondsToDelay = 0.6
            DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                if(self.diceNumberOne == self.diceNumberTwo && self.diceNumberOne == self.diceNumberThree && self.diceNumberOne == self.diceNumberFour && self.diceNumberOne == self.diceNumberFive ){
                    self.yahtzeeSFXPlayer.play()
                }
            }
        }
        
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let LandingVC = segue.destination as? ScoreScreenViewController else { return }
        
        LandingVC.diceValue1 = diceNumberOne
        LandingVC.diceValue2 = diceNumberTwo
        LandingVC.diceValue3 = diceNumberThree
        LandingVC.diceValue4 = diceNumberFour
        LandingVC.diceValue5 = diceNumberFive
        
        LandingVC.rollNumber = rollNumber
        
    }
    
    

}

