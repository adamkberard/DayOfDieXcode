//
//  PlayerScoreTracker.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/11/21.
//

import UIKit

@IBDesignable
class SimpleStatsTrackingComponent: TrackerComponent {

    // Mark: UI Vars
    @IBOutlet weak var plusPointButton: UIButton!
    @IBOutlet weak var minusPointButton: UIButton!
    
    // Mark: Outlet Functions
    @IBAction func plusPointButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .UNTRACKED, scorer: player!))
    }
    
    // Mark: Outlet Functions
    @IBAction func minusPointButtonPressed(_ sender: Any) {
        if points.isEmpty {
            return
        }
        points.removeLast()
    }
}
