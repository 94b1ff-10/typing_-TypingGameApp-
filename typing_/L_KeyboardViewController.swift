//
//  L_KeyboardViewController.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 5/3/2023.
//

import Foundation
import UIKit
import AVFoundation

class L_KeyboardViewController: UIViewController {
    
    // row 1
    @IBAction func key1_1(_ sender: UIButton) {
        key = "1"
        keyAction()
    }
    @IBAction func key1_2(_ sender: UIButton) {
        key = "2"
        keyAction()
    }
    @IBAction func key1_3(_ sender: UIButton) {
        key = "3"
        keyAction()
    }
    @IBAction func key1_4(_ sender: UIButton) {
        key = "4"
        keyAction()
    }
    @IBAction func key1_5(_ sender: UIButton) {
        key = "5"
        keyAction()
    }
    
    // row 2
    @IBAction func key2_1(_ sender: UIButton) {
        key = "Q"
        keyAction()
    }
    @IBAction func key2_2(_ sender: UIButton) {
        key = "W"
        keyAction()
    }
    @IBAction func key2_3(_ sender: UIButton) {
        key = "E"
        keyAction()
    }
    @IBAction func key2_4(_ sender: UIButton) {
        key = "R"
        keyAction()
    }
    @IBAction func key2_5(_ sender: UIButton) {
        key = "T"
        keyAction()
    }
    
    // row 3
    @IBAction func key3_1(_ sender: UIButton) {
        key = "A"
        keyAction()
    }
    @IBAction func key3_2(_ sender: UIButton) {
        key = "S"
        keyAction()
    }
    @IBAction func key3_3(_ sender: UIButton) {
        key = "D"
        keyAction()
    }
    @IBAction func key3_4(_ sender: UIButton) {
        key = "F"
        keyAction()
    }
    @IBAction func key3_5(_ sender: UIButton) {
        key = "G"
        keyAction()
    }
    @IBOutlet weak var informationKey: UIButton!
    @IBAction func informationKeyAction(_ sender: UIButton) {
        typingGame()
    }
    
    // row 4
    @IBAction func key4_1(_ sender: UIButton) {
        key = "Z"
        keyAction()
    }
    @IBAction func key4_2(_ sender: UIButton) {
        key = "X"
        keyAction()
    }
    @IBAction func key4_3(_ sender: UIButton) {
        key = "C"
        keyAction()
    }
    @IBAction func key4_4(_ sender: UIButton) {
        key = "V"
        keyAction()
    }
    @IBAction func key4_5(_ sender: UIButton) {
        key = "B"
        keyAction()
    }
    
    // Fix to the horizontal screen
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // Data ↓
    
    let letters: Array <String> =
    ["1", "2", "3", "4", "5",
     "Q", "W", "E", "R", "T",
     "A", "S", "D", "F", "G",
     "Z", "X", "C", "V", "B"]
    
    var key = ""
    
    var correct: Double = 40
    
    var informationKeyTitle: [String] = []
    
    var start = Date()
    
    var reset = false
    
    var player: AVAudioPlayer?
    
    // Life cycle method ↓
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        informationKey.setTitleColor(UIColor.lightGray, for: .disabled)
        tutorial()
    }
    
    // Functions for informationKey ↓
    
    func typingGame() {
        if reset {
            informationKey.setTitle("🎮", for: .normal)
            reset = false
        } else {
            informationKey.isEnabled = false
            countDown()
        }
    }
    
    func countDown() {
        var count = 3
        informationKey.setTitle("\(count)", for: .normal)
        count -= 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.informationKey.setTitle("\(count)", for: .normal)
            count -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.informationKey.setTitle("\(count)", for: .normal)
                count -= 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.setLetters()
                }
            }
        }
    }
    
    func setLetters() {
        for _ in 1 ... 40 {
            informationKeyTitle.append(letters.randomElement()!)
        }
        informationKey.setTitle("\(informationKeyTitle.prefix(5).joined())", for: .normal)
        start = Date.now
        key = ""
        correct = 40
    }
    
    // Function for keys ↓
    
    func keyAction() {
        
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let soundURL = Bundle.main.url(forResource: "keySound", withExtension: "wav") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.play()
            } catch {
                print("error")
            }
        }
        
        if key == informationKeyTitle.first {
            informationKeyTitle.removeFirst()
            informationKey.setTitle("\(informationKeyTitle.prefix(5).joined())", for: .normal)
        } else {
            correct -= 1
        }
        
        if informationKeyTitle.isEmpty && !informationKey.isEnabled {
            let finish = Date().timeIntervalSince(start)
            informationKey.setTitle("\(Int(correct/40*100))%\n\(Int(40/finish*60))c/min", for: .normal)
            reset = true
            self.informationKey.isEnabled = true
        }
    }
    
    // App description (first launch only)
    func tutorial() {
        if UserDefaults.standard.bool(forKey: "firstLunchKey") {
            let tutorialView = UIStoryboard(name: "TutorialView", bundle: nil)
            guard let tutorialViewController = tutorialView.instantiateInitialViewController() as? TutorialViewController else { return }
            present(tutorialViewController, animated: true)
            UserDefaults.standard.set(false, forKey: "firstLunchKey")
        }
    }
    
}
