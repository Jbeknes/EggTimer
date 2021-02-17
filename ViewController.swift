//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 157/255.0, green: 223/255.0, blue: 211/255.0, alpha: 1)
        
        progressBar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        progressBar.layer.cornerRadius = 20
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 20
        progressBar.subviews[1].clipsToBounds = true
        
     /*   stopTimer.textAlignment = .center
//        stopTimer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stopTimer.layer.cornerRadius = 20
        stopTimer.clipsToBounds = true
        //stopTimer.layer.sublayers![1].cornerRadius = 20
        //stopTimer.subviews[1].clipsToBounds = true*/
        
        countDownLabel.isHidden = true
        
    }

@IBOutlet weak var progressBar: UIProgressView!
@IBOutlet weak var titleLabel: UILabel!
@IBOutlet weak var countDownLabel: UILabel!
@IBOutlet weak var stopTimer: UILabel!
    
    
    let eggTimes =  ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var player = AVAudioPlayer()
    var totalTime = 0
    var secondsPassed = 0
    
@IBAction func hardnessSelected(_ sender: UIButton) {
    
    timer.invalidate()
    let hardness = sender.currentTitle!
    
    countDownLabel.isHidden = false
    countDownLabel.textAlignment = .center
    countDownLabel.textColor = UIColor.init(red: 49/255.0, green: 50/255.0, blue: 111/255.0, alpha: 1)
    countDownLabel.font = countDownLabel.font.withSize(40)
    
    totalTime = eggTimes[hardness]!
    titleLabel.font = titleLabel.font.withSize(30)
    progressBar.tintColor = UIColor.init(red: 255/255.0, green: 218/255.0, blue: 218/255.0, alpha: 1)
    progressBar.progress = 0.0
    
    secondsPassed = 0
    titleLabel.text = hardness
    titleLabel.textColor = UIColor.black
    
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
        }
    
    @IBAction func stopTimerButton(_ sender: UIButton) {
        timer.invalidate()
        
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
    func timeString(time: TimeInterval) -> String {
//let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        // return formated string
        return String(format: "%02i:%02i", minute, second)
                    }
            
            let i = ((totalTime) - (secondsPassed))
            countDownLabel.text = String(timeString(time: TimeInterval(i)))
                        
        } else {
            timer.invalidate()
            titleLabel.text = "Your Eggs Are DONE!"
            titleLabel.textColor = UIColor.init(red: 49/255.0, green: 50/255.0, blue: 111/255.0, alpha: 1)
            titleLabel.font = titleLabel.font.withSize(50)
            countDownLabel.text = ""
            
            let url = Bundle.main.url(forResource: "alarm_01", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
            
        }
    }
}
