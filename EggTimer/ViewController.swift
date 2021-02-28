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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var player: AVAudioPlayer!
    let eggTimes = ["Soft": 5, "Medium": 10, "Hard": 15]   //minutes to seconds
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    

    @IBAction func hardnessSelected(_ sender: UIButton) {       //3 buttons selected ("soft", "medium", "hard")
        
        timer.invalidate()
        let hardness = sender.currentTitle! //soft, medium, hard
        totalTime = eggTimes[hardness]!
        
        progressView.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        
            //target: call function update timer
       timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {      //to make this ojc func we add @objc
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = Float(percentageProgress)
        } else {
            timer.invalidate()
            titleLabel.text = "Done!"
            
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
}
