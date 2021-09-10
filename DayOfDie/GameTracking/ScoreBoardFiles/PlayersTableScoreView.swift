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
    @IBOutlet weak var teamTwoScoreLabel: UILabel!
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerThreeLabel: UILabel!
    @IBOutlet weak var playerFourLabel: UILabel!
    
    var teamOneScore : Int = 0 {
        didSet {teamOneScoreLabel.text = "Team One: \(teamOneScore)"}
    }
    var teamTwoScore : Int = 0 {
        didSet {teamTwoScoreLabel.text = "Team Two: \(teamTwoScore)"}
    }
    var playerOne : User = User(username: "playerOne") {
        didSet{
            playerOneLabel.text = playerOne.username
        }
    }
    var playerTwo : User = User(username: "playerTwo"){
        didSet{
            playerTwoLabel.text = playerTwo.username
        }
    }
    var playerThree : User = User(username: "playerThree"){
        didSet{
            playerThreeLabel.text = playerThree.username
        }
    }
    var playerFour : User = User(username: "playerFour"){
        didSet{
            playerFourLabel.text = playerFour.username
        }
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
