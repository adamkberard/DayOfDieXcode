//
//  JustScoreTrackerComponent.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import UIKit


class JustScoreTrackerComponent: SimpleStatsTrackingComponent {
    // Mark: UI Vars
    
    override var playerNumber: Int {
        didSet {
            if playerNumber <= 1{
                playerLabel.text = "Team One"
            }
            else {
                playerLabel.text = "Team Two"
            }
        }
    }
}
