//
//  PlayersTableScoreView.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/21/21.
//

import UIKit

@IBDesignable
class PlayersTableScoreView: UIView {
    
    @IBOutlet weak var teamOneScoreLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    @IBOutlet var playerLabels: [UILabel]! {
        didSet {
            playerLabels.sort { $0.tag < $1.tag }
        }
    }
    
    var players : [Player] = [] {
        didSet{
            for i in 0..<playerLabels.count{
                playerLabels[i].text = players[i].username
            }
        }
    }
    
    var teamOneScore : Int = 0 {
        didSet {teamOneScoreLabel.text = "Team One: \(teamOneScore)"}
    }
    var awayTeamScore : Int = 0 {
        didSet {awayTeamScoreLabel.text = "Team Two: \(awayTeamScore)"}
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
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        playerLabels[0].textColor = ColorSettings.homeTeamColor
        playerLabels[1].textColor = ColorSettings.homeTeamColor
        playerLabels[2].textColor = ColorSettings.awayTeamColor
        playerLabels[3].textColor = ColorSettings.awayTeamColor
        
        teamOneScoreLabel.textColor = ColorSettings.homeTeamColor
        awayTeamScoreLabel.textColor = ColorSettings.awayTeamColor
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return view
    }
}
