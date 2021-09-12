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
    
    // Mark: View Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return view
    }
    
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
