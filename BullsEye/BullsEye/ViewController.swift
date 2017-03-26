//
//  ViewController.swift
//  BullsEye
//
//  Created by Alex Belogurow on 12.03.17.
//  Copyright © 2017 Alex Belogurow. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var scoreValue: Int = 0
    var roundValue: Int = 0
    var scoreFromRound: Int = 0

    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        
        roundValue += 1
        scoreValue += scoreFromRound
    }
    
    func startNewGame() {
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        roundValue = 1
        scoreValue = 0
        

    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        roundLabel.text = String(roundValue)
        scoreLabel.text = String(scoreValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewGame()
        updateLabels()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value)
        
        
    }

    @IBAction func restartTapped(_ sender: UIButton) {
        startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            view.layer.add(transition, forKey: nil)
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        scoreFromRound = 100 - difference
        
        let message = "Your scored \(scoreFromRound) points"
        
        let alert = UIAlertController(title: "Your Score",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: {action in
                                    self.startNewRound()
                                    self.updateLabels() })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        // test branch
        // something happened
        
        // else test
    
    }
}

