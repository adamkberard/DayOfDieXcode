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
        
        if freshLaunch == true {
            freshLaunch = false
            selectedIndex = 1 // 5th tab
        }
    }
}
