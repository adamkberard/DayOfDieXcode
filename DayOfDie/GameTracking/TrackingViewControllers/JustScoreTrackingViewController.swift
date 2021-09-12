//
//  JustScoreTrackingViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/11/21.
//

import UIKit

class JustScoreTrackingViewController: TrackingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        scoreboard.players = players
        
        for i in 0...3 {
            trackerComponents[i].mainTrackingViewController = self
            trackerComponents[i].player = players[i]
            trackerComponents[i].playerNumber = i
        }
        scoreboard.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
}
