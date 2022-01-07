//
//  ViewController.swift
//  kennyGame
//
//  Created by Muhammed Süha Demirel on 7.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var counter = 0
    var timer = Timer()
    var hiddenTimer = Timer()
    var imageArray = [UIImageView]()
    var highScore = 0
    
    
    @IBOutlet weak var theOne: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
            
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            theOne.text = "gg: \(highScore)"


        }
        
        imageArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        // Do any additional setup after loading the view.
        scoreLabel.text = "Score: \(score)"

        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
                
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        counter = 10
        timeLabel.text = "Time: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCountDown), userInfo: nil, repeats: true)
        
        hiddenTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(hideTheImages), userInfo: nil, repeats: true)
        
        hideTheImages()

    }
    
    @objc func hideTheImages(){
        for img in imageArray{
            img.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(imageArray.count-1)))
        
        imageArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    
    @objc func timerCountDown(){
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hiddenTimer.invalidate()
            
            
            for img in imageArray{
                img.isHidden = true
            }
            
            if self.score > self.highScore{
                self.highScore = self.score
                theOne.text = "gg = \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "gg")
            }
            
            let alert = UIAlertController(title: "Time is up!", message: "Again ?!?", preferredStyle: UIAlertController.Style.alert)
            
            let confirmButton = UIAlertAction(title: "Yes, Play Again!", style: UIAlertAction.Style.default){(UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCountDown), userInfo: nil, repeats: true)
                
                self.hiddenTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(self.hideTheImages), userInfo: nil, repeats: true)
                
            }
            
            let cancelmButton = UIAlertAction(title: "I'm Done.", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(confirmButton)
            alert.addAction(cancelmButton)
            self.present(alert, animated: true, completion: nil)
        }
    }


}

