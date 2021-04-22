//
//  StartPageViewController.swift
//  cleanerLife
//
//  Created by Adam Berard on 12/26/20.
//

import UIKit

var currentUser = AuthUser()
var userGames : [Game] = []
var userFriends : [Friend] = []

class StartViewController:
    UIViewController, UITextFieldDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Check if token exists
        //if CurrentUser.token != ""  
    }
}
