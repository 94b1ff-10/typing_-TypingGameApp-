//
//  KeyboardViewController.swift
//  migite
//
//  Created by TEN MATSUMOTO on 28/11/2022.
//

import Foundation
import UIKit

class KeyboardViewController: UIViewController {
    
    // row 1
    @IBAction func key1_1(_ sender: UIButton) {
        key = "6"
        keyAction()
    }
    @IBAction func key1_2(_ sender: UIButton) {
        key = "7"
        keyAction()
    }
    @IBAction func key1_3(_ sender: UIButton) {
        key = "8"
        keyAction()
    }
    @IBAction func key1_4(_ sender: UIButton) {
        key = "9"
        keyAction()
    }
    @IBAction func key1_5(_ sender: UIButton) {
        key = "0"
        keyAction()
    }
    @IBAction func key1_6(_ sender: UIButton) {
        key = "-"
        keyAction()
    }
    @IBAction func key1_7(_ sender: UIButton) {
        key = "^"
        keyAction()
    }
    
    // row 2
    @IBAction func key2_1(_ sender: UIButton) {
        key = "Y"
        keyAction()
    }
    @IBAction func key2_2(_ sender: UIButton) {
        key = "U"
        keyAction()
    }
    @IBAction func key2_3(_ sender: UIButton) {
        key = "I"
        keyAction()
    }
    @IBAction func key2_4(_ sender: UIButton) {
        key = "O"
        keyAction()
    }
    @IBAction func key2_5(_ sender: UIButton) {
        key = "P"
        keyAction()
    }
    @IBAction func key2_6(_ sender: UIButton) {
        key = "@"
        keyAction()
    }
    @IBAction func key2_7(_ sender: UIButton) {
        key = "["
        keyAction()
    }
    
    // row 3
    @IBAction func key3_1(_ sender: UIButton) {
        key = "H"
        keyAction()
    }
    @IBAction func key3_2(_ sender: UIButton) {
        key = "J"
        keyAction()
    }
    @IBAction func key3_3(_ sender: UIButton) {
        key = "K"
        keyAction()
    }
    @IBAction func key3_4(_ sender: UIButton) {
        key = "L"
        keyAction()
    }
    @IBAction func key3_5(_ sender: UIButton) {
        key = ";"
        keyAction()
    }
    @IBAction func key3_6(_ sender: UIButton) {
        key = ":"
        keyAction()
    }
    @IBAction func key3_7(_ sender: UIButton) {
        key = "]"
        keyAction()
    }
    
    // row 4
    @IBOutlet weak var informationKey: UIButton!
    @IBAction func informationKeyAction(_ sender: UIButton) {
        typingGame()
    }
    @IBAction func key4_1(_ sender: UIButton) {
        key = "N"
        keyAction()
    }
    @IBAction func key4_2(_ sender: UIButton) {
        key = "M"
        keyAction()
    }
    @IBAction func key4_3(_ sender: UIButton) {
        key = ","
        keyAction()
    }
    @IBAction func key4_4(_ sender: UIButton) {
        key = "."
        keyAction()
    }
    @IBAction func key4_5(_ sender: UIButton) {
        key = "/"
        keyAction()
    }
    @IBAction func key4_6(_ sender: UIButton) {
        key = "_"
        keyAction()
    }
    
    // Fix to the horizontal screen
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // Data ↓
    
    let letters: Array <String> =
    ["6", "7", "8", "9", "0", "-", "^",
     "Y", "U", "I", "O", "P", "@", "[",
     "H", "J", "K", "L", ";", ":", "]",
     "N", "M", ",", ".", "/", "_"]
    
    var key = ""
    
    var correct: Double = 40
    
    var informationKeyTitle: [String] = []
    
    var start = Date()
    
    var reset = false
    
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
