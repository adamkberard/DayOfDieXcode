//
//  RuleRowView.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/19/21.
//

import UIKit

enum RuleTypes : String {
    case regular = "Regular Point"
    case tink = "Tink"
    case sink = "Sink"
    case bounceSink = "Bounce Sink"
    case partnerSink = "Partner Sink"
    case selfSink = "Self Sink"
    case fifa = "Fifa"
    case fieldGoal = "Field Goal"
    case winBy = "Win By"
    case playTo = "Play To"
}

@IBDesignable
class RuleRow: UIView {
    
    var points : Int = 0
    
    @IBOutlet weak var ruleSwitch: UISwitch!
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    func commonSetup() {
        let view = viewFromNibForClass()
        view.frame = bounds

        // Auto-layout stuff.
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]

        // Show the view.
        addSubview(view)
        
        // My Stuff
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return view
    }
    
    func mySetup(type: RuleTypes) {
        ruleLabel.text = type.rawValue
        switch type {
        case .regular:
            points = 1
        case .tink:
            points = 2
        case .sink:
            points = 3
        case .bounceSink:
            points = 2
        case .partnerSink:
            points = 0
        case .selfSink:
            points = 0
        case .fifa:
            points = 1
            ruleSwitch.isOn = false
            plusButton.isEnabled = false
            minusButton.isEnabled = false
        case .fieldGoal:
            points = 2
            points = 0
            ruleSwitch.isOn = false
            plusButton.isEnabled = false
            minusButton.isEnabled = false
        case .winBy:
            points = 2
        case .playTo:
            points = 11
        }
        pointsLabel.text = String(points)
    }
    
    @IBAction func minusButtonPressed(_ sender: Any) {
        if points == 0 { return }
        else { points -= 1 }
        pointsLabel.text = String(points)
    }
    
    
    @IBAction func plusButtonPressed(sender: UIButton!) {
        points += 1
        pointsLabel.text = String(points)
    }
}
