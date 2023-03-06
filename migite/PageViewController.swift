//
//  PageViewController.swift
//  migite
//
//  Created by TEN MATSUMOTO on 6/3/2023.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController {

    private var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPageView()
    }
    
    func initPageView(){
        let RightKeyboardVC = storyboard!.instantiateViewController(withIdentifier: "RightKeyboardView") as! R_KeyboardViewController
        let LeftKeyboardVC = storyboard!.instantiateViewController(withIdentifier: "LeftKeyboardView") as! L_KeyboardViewController
        
        self.controllers = [ LeftKeyboardVC, RightKeyboardVC ]
        
        setViewControllers([self.controllers[0]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
        self.dataSource = self
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.controllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
            index < self.controllers.count - 1 {
            return self.controllers[index + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController),
            index > 0 {
            return self.controllers[index - 1]
        } else {
            return nil
        }
    }
}
