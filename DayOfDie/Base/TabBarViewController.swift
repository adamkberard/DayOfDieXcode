//
//  TabBarViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/24/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    var freshLaunch = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting player for the profile
        guard let profileNavigationVC = viewControllers?.last as? UINavigationController, let rootVC = profileNavigationVC.viewControllers.first as? ProfileViewController else {
            fatalError("The last tab isn't the profile???")
        }
        rootVC.player = User.player
        let _ = rootVC.view
        
        // Preloads all the views
//        for viewController in viewControllers ?? [] {
//            if let navigationVC = viewController as? UINavigationController, let rootVC = navigationVC.viewControllers.first {
//                print("NAv")
//                let _ = rootVC.view
//            } else {
//                print("not nav")
//                let _ = viewController.view
//            }
//        }
        
        if freshLaunch == true {
            freshLaunch = false
            selectedIndex = 1 // 5th tab
        }
    }
}
