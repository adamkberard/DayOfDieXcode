//
//  PlayerScorePicker.swift
//
//
//  Created by Adam Berard on 4/21/21.
//

import UIKit

@IBDesignable
class FullStatsTrackerComponent: TrackerComponent {

    // Mark: UI Vars
    @IBOutlet weak var regularPointButton: UIButton!
    @IBOutlet weak var tinkButton: UIButton!
    @IBOutlet weak var sinkButton: UIButton!
    @IBOutlet weak var bounceSinkButton: UIButton!
    @IBOutlet weak var partnerSinkButton: UIButton!
    @IBOutlet weak var selfSinkButton: UIButton!
    @IBOutlet weak var fifaButton: UIButton!
    @IBOutlet weak var fieldGoalButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    
    override func commonSetup() {
        super.commonSetup()
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    // Mark: Outlet Functions
    @IBAction func regularButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .REGULAR, scorer: player!))
    }
    @IBAction func tinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .TINK, scorer: player!))
    }
    @IBAction func sinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .SINK, scorer: player!))
    }
    @IBAction func bounceSinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .BOUNCE_SINK, scorer: player!))
    }
    @IBAction func partnerSinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .PARTNER_SINK, scorer: player!))
    }
    @IBAction func selfSinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .SELF_SINK, scorer: player!))
    }
    @IBAction func fifaButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .FIFA, scorer: player!))
    }
    @IBAction func fieldGoalButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .FIELD_GOAL, scorer: player!))
    }
    @IBAction func fiveButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .FIVE, scorer: player!))
    }
}
