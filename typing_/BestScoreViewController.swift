//
//  BestScoreViewController.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 20/3/2023.
//

import Foundation
import UIKit

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
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func moveToRecordView(_ sender: UIButton) {
        let recordViewController = self.storyboard?.instantiateViewController(withIdentifier: "RecordView") as! RecordViewController
        present(recordViewController, animated: true)
    }
    
}
