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
        
        if !points.isEmpty {
            minusPointButton.isEnabled = true
        }
    }
    
    // Mark: Outlet Functions
    @IBAction func minusPointButtonPressed(_ sender: Any) {
        // This should never be called
        if points.isEmpty {
            minusPointButton.isEnabled = false
            return
        }
        
        points.removeLast()
        
        if points.isEmpty {
            minusPointButton.isEnabled = false
        }
    }
}
