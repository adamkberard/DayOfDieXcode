//
//  PlayersTableScoreView.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/21/21.
//

import UIKit

@IBDesignable
class PlayersTableScoreView: UIView {

    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerThreeLabel: UILabel!
    @IBOutlet weak var playerFourLabel: UILabel!
    
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    @IBOutlet weak var playerThreeScoreLabel: UILabel!
    @IBOutlet weak var playerFourScoreLabel: UILabel!
    
    var playerOne : BasicUser? {
        didSet {
            playerOneLabel.text = playerOne!.username
        }
    }
    var playerTwo : BasicUser? {
        didSet {
            playerTwoLabel.text = playerTwo!.username
        }
    }
    var playerThree : BasicUser? {
        didSet {
            playerThreeLabel.text = playerThree!.username
        }
    }
    var playerFour : BasicUser? {
        didSet {
            playerFourLabel.text = playerFour!.username
        }
    }
    
    var playerOnePoints : Int = 0 {
        didSet {
            playerOneScoreLabel.text = "Score: \(playerOnePoints)"
        }
    }
    var playerTwoPoints : Int = 0 {
        didSet {
            playerTwoScoreLabel.text = "Score: \(playerTwoPoints)"
        }
    }
    var playerThreePoints : Int = 0 {
        didSet {
            playerThreeScoreLabel.text = "Score: \(playerThreePoints)"
        }
    }
    var playerFourPoints : Int = 0 {
        didSet {
            playerFourScoreLabel.text = "Score: \(playerFourPoints)"
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
    
    func setPlayers(players: [BasicUser]){
        playerOne = players[0]
        playerTwo = players[1]
        playerThree = players[2]
        playerFour = players[3]
    }
    
    func setPlayers(playerOne: BasicUser, playerTwo: BasicUser, playerThree: BasicUser, playerFour: BasicUser){
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.playerThree = playerThree
        self.playerFour = playerFour
    }

}
