//
//  L_KeyboardViewController.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 5/3/2023.
//

import Foundation
import UIKit
import RealmSwift
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
    
    @IBAction func recordKey(_ sender: Any) {
        let recordViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecordView") as! RecordViewController
        present(recordViewController, animated: true)
    }
    
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
    
    var player: AVAudioPlayer?
    
    // Life cycle method ↓
    
    override func viewDidLoad() {
        super.viewDidLoad()
        informationKey.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    // Functions for informationKey ↓
    
    func typingGame() {
        informationKey.isEnabled = false
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
        
        if key == informationKeyTitle.first {
            informationKeyTitle.removeFirst()
            informationKey.setTitle("\(informationKeyTitle.prefix(5).joined())", for: .normal)
        } else {
            correct -= 1
        }
        
        if informationKeyTitle.isEmpty && !informationKey.isEnabled {
            let finish = Date().timeIntervalSince(start)
            let resultData = DataModel()
            let realm = try! Realm()
            try! realm.write {
                resultData.recordDate = Date()
                resultData.sides = "Left"
                resultData.accuracy = Int(correct/40*100)
                resultData.speed = Int(40/finish*60)
                realm.add(resultData)
            }
            typingResult(accuracy: Int(correct/40*100), speed: Int(40/finish*60))
        }
    }
    
    // alert for result ↓
    
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

