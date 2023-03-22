//
//  KeyboardViewController.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 28/11/2022.
//

import Foundation
import UIKit
import RealmSwift
import AVFoundation

class R_KeyboardViewController: UIViewController {
    
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
    
    var key = String()
    
    var inGame: Bool = Bool()
    
    var correct: Double = 40
    
    var mistakes: [String] = []
    
    var randomLetters: [String] = []
    
    var start = Date()
    
    var player: AVAudioPlayer?
    
    // Life cycle method ↓
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationKey.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    // Functions for informationKey ↓
    
    func typingGame() {
        informationKey.isEnabled = false
        informationKey.setTitle("3", for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.informationKey.setTitle("2", for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.informationKey.setTitle("1", for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.setLetters()
            
        }
    }
    
    func setLetters() {
        randomLetters = (0..<40).map { _ in String(letters.randomElement()!) }
        informationKey.setTitle("\(randomLetters.prefix(5).joined())", for: .normal)
        start = Date.now
        key.removeAll()
        correct = 40
        mistakes.removeAll()
        inGame = true
    }
    
    // Function for keys ↓
    
    func keyAction() {
        
        // haptic
        UISelectionFeedbackGenerator().selectionChanged()
        
        if let soundURL = Bundle.main.url(forResource: "keySound", withExtension: "wav") {
            do {
                player = try AVAudioPlayer(contentsOf: soundURL)
                player?.play()
            } catch {
                print("error")
            }
        }
        
        if inGame {
            if key == randomLetters.first {
                randomLetters.removeFirst()
                informationKey.setTitle("\(randomLetters.prefix(5).joined())", for: .normal)
            } else {
                correct -= 1
                mistakes += [key]
            }
            
            if randomLetters.isEmpty {
                let finish = Date().timeIntervalSince(start)
                let resultData = DataModel()
                let mistakeCounts = mistakes.reduce(into: [:]) { counts, mistake in
                    counts[mistake, default: 0] += 1
                }
                let sortedMistakes = mistakes.sorted { mistakeCounts[$0]! > mistakeCounts[$1]! }
                let realm = try! Realm()
                resultData.recordDate = Date()
                resultData.sides = "Right"
                resultData.duration = (finish * 100).rounded() / 100
                resultData.accuracy = Int(correct/40*100)
                resultData.speed = Int(40/finish*60)
                resultData.weakKey = sortedMistakes.first ?? "N/A"
                try! realm.write {
                    realm.add(resultData)
                }
                inGame = false
                typingResult(accuracy: Int(correct/40*100), speed: Int(40/finish*60))
            }
        }
    }
    
    // alert view for result ↓
    
    func typingResult(accuracy: Int, speed: Int) {
        
        let alert = UIAlertController(title: "Accuracy: \(accuracy)%\nSpeed: \(speed)c/min", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "↩︎ Enter", style: .default, handler: { (action) -> Void in
            self.informationKey.setTitle("🎮", for: .normal)
            self.informationKey.isEnabled = true
        })
        
        alert.view.tintColor = UIColor.black
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
