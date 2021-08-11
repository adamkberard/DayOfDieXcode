//
//  PlayersTableScoreView.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/21/21.
//

import UIKit

@IBDesignable
class PlayersTableScoreView: UIView {
    
    @IBOutlet weak var teamOneLabel: UILabel!
    @IBOutlet weak var teamTwoLabel: UILabel!
    
    @IBOutlet weak var teamOneScoreLabel: UILabel!
    @IBOutlet weak var teamTwoScoreLabel: UILabel!
    
    var teamOneScore : Int = 0 {
        didSet {teamOneScoreLabel.text = String(teamOneScore)}
    }
    var teamTwoScore : Int = 0 {
        didSet {teamTwoScoreLabel.text = String(teamTwoScore)}
    }

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
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return view
    }
}
