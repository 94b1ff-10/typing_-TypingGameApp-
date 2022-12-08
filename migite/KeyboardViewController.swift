//
//  KeyboardViewController.swift
//  migite
//
//  Created by TEN MATSUMOTO on 28/11/2022.
//

import Foundation
import UIKit

class KeyboardViewController: UIViewController {
    
    //Fix to the horizontal screen
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tutorial()
    }
    
    //App description (first launch only)
    func tutorial() {
        if UserDefaults.standard.bool(forKey: "firstLunchKey") {
            let tutorialView = UIStoryboard(name: "TutorialView", bundle: nil)
            guard let tutorialViewController = tutorialView.instantiateInitialViewController() as? TutorialViewController else { return }
            present(tutorialViewController, animated: true)
            UserDefaults.standard.set(false, forKey: "firstLunchKey")
        }
    }
    
}
