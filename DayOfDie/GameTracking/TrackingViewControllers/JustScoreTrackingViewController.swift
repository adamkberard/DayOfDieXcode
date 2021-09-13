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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    override func getPointsForParameters() -> [[String: String]] {
        return []
    }
}
