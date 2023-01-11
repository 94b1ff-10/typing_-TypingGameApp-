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
    }
    @IBAction func key1_2(_ sender: UIButton) {
    }
    @IBAction func key1_3(_ sender: UIButton) {
    }
    @IBAction func key1_4(_ sender: UIButton) {
    }
    @IBAction func key1_5(_ sender: UIButton) {
    }
    @IBAction func key1_6(_ sender: UIButton) {
    }
    @IBAction func key1_7(_ sender: UIButton) {
    }
    
    // row 2
    @IBAction func key2_1(_ sender: UIButton) {
    }
    @IBAction func key2_2(_ sender: UIButton) {
    }
    @IBAction func key2_3(_ sender: UIButton) {
    }
    @IBAction func key2_4(_ sender: UIButton) {
    }
    @IBAction func key2_5(_ sender: UIButton) {
    }
    @IBAction func key2_6(_ sender: UIButton) {
    }
    @IBAction func key2_7(_ sender: UIButton) {
    }
    
    // row 3
    @IBAction func key3_1(_ sender: UIButton) {
    }
    @IBAction func key3_2(_ sender: UIButton) {
    }
    @IBAction func key3_3(_ sender: UIButton) {
    }
    @IBAction func key3_4(_ sender: UIButton) {
    }
    @IBAction func key3_5(_ sender: UIButton) {
    }
    @IBAction func key3_6(_ sender: UIButton) {
    }
    @IBAction func key3_7(_ sender: UIButton) {
    }
    
    // row 4
    @IBOutlet weak var informationKey: UIButton!
    @IBAction func informationKeyAction(_ sender: UIButton) {
        typingGame()
    }
    @IBAction func key4_2(_ sender: UIButton) {
    }
    @IBAction func key4_3(_ sender: UIButton) {
    }
    @IBAction func key4_4(_ sender: UIButton) {
    }
    @IBAction func key4_5(_ sender: UIButton) {
    }
    @IBAction func key4_6(_ sender: UIButton) {
    }
    @IBAction func key4_7(_ sender: UIButton) {
    }
    
    // Fix to the horizontal screen
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    // 27 letters
    let letter: Array <String> =
    ["6", "7", "8", "9", "0", "-", "^",
     "Y", "U", "I", "O", "P", "@", "[",
     "H", "J", "K", "L", ";", ":", "]",
     "N", "M", ",", ".", "/", "_"]
    
    var appearLetters: [String] = []
    
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
    
    func typingGame() {
        informationKey.isEnabled = false
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
                    self.gameStart()
                    self.informationKey.isEnabled = true
                }
            }
        }
    }
    
    func gameStart() {
        
    }
    
    func configureInformationKey() {
        informationKey.setTitleColor(UIColor.lightGray, for: .disabled)
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
