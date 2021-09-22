//
//  ProfileViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import UIKit

class ProfileViewController: PlayerViewController {
    @IBOutlet weak var requestsButton: UIButton!
    
    override func viewDidLoad() {
        player = User.player
        tableObjectList = Game.allGames
        super.viewDidLoad()
    }
    
    override func setTeamStatusLabelAndButton() {
        
    }
    
    @IBAction func requestsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toTeamRequests", sender: self)
    }
}
