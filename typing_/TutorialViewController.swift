//
//  TutorialViewController.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 28/11/2022.
//

import Foundation
import UIKit

class TutorialViewController: UIViewController {
    
    // Fix to the vertical screen
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
