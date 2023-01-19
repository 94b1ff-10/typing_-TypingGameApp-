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
        inputLetter()
    }
    @IBAction func key1_2(_ sender: UIButton) {
        key = "7"
        inputLetter()
    }
    @IBAction func key1_3(_ sender: UIButton) {
        key = "8"
        inputLetter()
    }
    @IBAction func key1_4(_ sender: UIButton) {
        key = "9"
        inputLetter()
    }
    @IBAction func key1_5(_ sender: UIButton) {
        key = "0"
        inputLetter()
    }
    @IBAction func key1_6(_ sender: UIButton) {
        key = "-"
        inputLetter()
    }
    @IBAction func key1_7(_ sender: UIButton) {
        key = "^"
        inputLetter()
    }
    
    // row 2
    @IBAction func key2_1(_ sender: UIButton) {
        key = "Y"
        inputLetter()
    }
    @IBAction func key2_2(_ sender: UIButton) {
        key = "U"
        inputLetter()
    }
    @IBAction func key2_3(_ sender: UIButton) {
        key = "I"
        inputLetter()
    }
    @IBAction func key2_4(_ sender: UIButton) {
        key = "O"
        inputLetter()
    }
    @IBAction func key2_5(_ sender: UIButton) {
        key = "P"
        inputLetter()
    }
    @IBAction func key2_6(_ sender: UIButton) {
        key = "@"
        inputLetter()
    }
    @IBAction func key2_7(_ sender: UIButton) {
        key = "["
        inputLetter()
    }
    
    // row 3
    @IBAction func key3_1(_ sender: UIButton) {
        key = "H"
        inputLetter()
    }
    @IBAction func key3_2(_ sender: UIButton) {
        key = "J"
        inputLetter()
    }
    @IBAction func key3_3(_ sender: UIButton) {
        key = "K"
        inputLetter()
    }
    @IBAction func key3_4(_ sender: UIButton) {
        key = "L"
        inputLetter()
    }
    @IBAction func key3_5(_ sender: UIButton) {
        key = ";"
        inputLetter()
    }
    @IBAction func key3_6(_ sender: UIButton) {
        key = ":"
        inputLetter()
    }
    @IBAction func key3_7(_ sender: UIButton) {
        key = "]"
        inputLetter()
    }
    
    // row 4
    @IBOutlet weak var informationKey: UIButton!
    @IBAction func informationKeyAction(_ sender: UIButton) {
        typingGame()
    }
    @IBAction func key4_1(_ sender: UIButton) {
        key = "N"
        inputLetter()
    }
    @IBAction func key4_2(_ sender: UIButton) {
        key = "M"
        inputLetter()
    }
    @IBAction func key4_3(_ sender: UIButton) {
        key = ","
        inputLetter()
    }
    @IBAction func key4_4(_ sender: UIButton) {
        key = "."
        inputLetter()
    }
    @IBAction func key4_5(_ sender: UIButton) {
        key = "/"
        inputLetter()
    }
    @IBAction func key4_6(_ sender: UIButton) {
        key = "_"
        inputLetter()
    }
    
    // Fix to the horizontal screen
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // Data
    let letters: Array <String> =
    ["6", "7", "8", "9", "0", "-", "^",
     "Y", "U", "I", "O", "P", "@", "[",
     "H", "J", "K", "L", ";", ":", "]",
     "N", "M", ",", ".", "/", "_"]
    
    var key = ""
    
    var informationKeyTitle: [String] = []
    
    // Life cycle method ↓
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInformationKey()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tutorial()
    }
    
    // Functions for informationKey ↓
    
    func configureInformationKey() {
        informationKey.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    func typingGame() {
        informationKey.isEnabled = false
        key = ""
        countDown()
//        self.informationKey.isEnabled = true // タイピングゲームの最後に記述
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
                    //self.gameStart()
                }
            }
        }
    }
    
    func setLetters() {
        for _ in 1 ... 40 {
            informationKeyTitle.append(letters.randomElement()!)
        }
        informationKey.setTitle("\(informationKeyTitle.prefix(5).joined())", for: .normal)
    }
    
    func gameStart() {
        let start = Date()
        // action
        let finish = Date().timeIntervalSince(start)
        print(finish)
    }
    
    // Function for keys ↓
    
    func inputLetter() {
        if key == informationKeyTitle.first {
            informationKeyTitle.removeFirst()
            informationKey.setTitle("\(informationKeyTitle.prefix(5).joined())", for: .normal)
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
