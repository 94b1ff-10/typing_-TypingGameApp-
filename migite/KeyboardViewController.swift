//
//  KeyboardViewController.swift
//  migite
//
//  Created by TEN MATSUMOTO on 28/11/2022.
//

import Foundation
import UIKit

class KeyboardViewController: UIViewController {
    
    //横画面に固定
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//            let userDefaults = UserDefaults.standard
//            let firstLunchKey = "firstLunchKey"
//            if userDefaults.bool(forKey: firstLunchKey) {
//                let storyboard = UIStoryboard(name: "TutorialView", bundle: nil)
//                guard let viewController = storyboard.instantiateInitialViewController() as? TutorialViewController else { return }
//                present(viewController, animated: true)
//        }
//    }
}
