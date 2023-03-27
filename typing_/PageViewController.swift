//
//  PageViewController.swift
//  typing_
//
//  Created by TEN MATSUMOTO on 6/3/2023.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController {
    
    // Fix to the horizontal screen
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    private var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Onboarding only appear first launch (TutorialView)
        if UserDefaults.standard.bool(forKey: "firstLunchKey") {
            let tutorialViewController = self.storyboard?.instantiateViewController(withIdentifier: "TutorialView") as! TutorialViewController
            present(tutorialViewController, animated: true)
            UserDefaults.standard.set(false, forKey: "firstLunchKey")
        }
    }
    
    func initPageView(){
        let L_KeyboardVC = storyboard!.instantiateViewController(withIdentifier: "LeftKeyboardView") as! L_KeyboardViewController
        let R_KeyboardVC = storyboard!.instantiateViewController(withIdentifier: "RightKeyboardView") as! R_KeyboardViewController
        
        controllers = [ L_KeyboardVC, R_KeyboardVC ]
        setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
        dataSource = self
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController), index < controllers.count - 1 {
            return controllers[index + 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController), index > 0 {
            return controllers[index - 1]
        }
        return nil
    }
}
