//
//  BestScoreViewController.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 20/3/2023.
//

import Foundation
import UIKit
import RealmSwift

class BestScoreViewController: UIViewController {
    
    // Left score
    @IBOutlet weak var leftDuration: UILabel!
    @IBOutlet weak var leftAccuracy: UILabel!
    @IBOutlet weak var leftSpeed: UILabel!
    @IBOutlet weak var leftWeakKey: UILabel!
    
    // Right score
    @IBOutlet weak var rightDuration: UILabel!
    @IBOutlet weak var rightAccuracy: UILabel!
    @IBOutlet weak var rightSpeed: UILabel!
    @IBOutlet weak var rightWeakKey: UILabel!
    
    var realm: Realm!
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func moveToRecordView(_ sender: UIButton) {
        let recordViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecordView") as! RecordViewController
        present(recordViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the default Realm
        realm = try! Realm()
        
        // Get the best left and right scores for each category
        let bestLeftScores = getBestScores(for: "Left")
        let bestRightScores = getBestScores(for: "Right")
        
        // Set the text of the labels to show the best scores
        leftDuration.text = String(format: "%.2f", bestLeftScores.duration) + " sec"
        leftAccuracy.text = String(bestLeftScores.accuracy) + " %"
        leftSpeed.text = String(bestLeftScores.speed) + " c/min"
        leftWeakKey.text = bestLeftScores.weakKey
        
        rightDuration.text = String(format: "%.2f", bestRightScores.duration) + " sec"
        rightAccuracy.text = String(bestRightScores.accuracy) + " %"
        rightSpeed.text = String(bestRightScores.speed) + " c/min"
        rightWeakKey.text = bestRightScores.weakKey
    }
    
    // Get the best scores for the given sides (Left or Right)
    func getBestScores(for sides: String) -> DataModel {
        // Get all scores for the given sides from the database
        let scores = realm.objects(DataModel.self).filter("sides == %@", sides)
        
        // Get the score with the minimum duration
        let bestDuration = scores.min(ofProperty: "duration") as Double? ?? 0
        let bestDurationScore = scores.filter("duration == %@", bestDuration).first ?? DataModel()
        
        // Get the score with the highest speed
        let bestSpeed = scores.max(ofProperty: "speed") as Int? ?? 0
        let bestSpeedScore = scores.filter("speed == %@", bestSpeed).first ?? DataModel()
        
        // Get the score with the accuracy closest to 100
        let closestAccuracy = scores.sorted(byKeyPath: "accuracy").min(by: { abs($0.accuracy - 100) < abs($1.accuracy - 100) })
        let closestAccuracyScore = closestAccuracy ?? DataModel()
        
        // Get the most common weak key
        let mostCommonWeakKey = scores.reduce([String: Int]()) { (dict, score) -> [String: Int] in
            var dict = dict
            dict[score.weakKey, default: 0] += 1
            return dict
        }.max { $0.value < $1.value }?.key ?? ""
        
        let bestScore = DataModel()
        bestScore.duration = bestDurationScore.duration
        bestScore.accuracy = closestAccuracyScore.accuracy
        bestScore.speed = bestSpeedScore.speed
        bestScore.weakKey = mostCommonWeakKey
        
        return bestScore
    }
}
