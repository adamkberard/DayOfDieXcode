//
//  GameTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit

class GameCell: BaseTableViewCell<Game> {

    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerThreeLabel: UILabel!
    @IBOutlet weak var playerFourLabel: UILabel!
    @IBOutlet weak var teamOneScore: UILabel!
    @IBOutlet weak var teamTwoScore: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    var game : Game!
    
    override func setupCell(object: Game) {
        self.game = object
        
        self.playerOneLabel.text = object.teamOne.teamCaptain.username
        self.playerTwoLabel.text = object.teamOne.teammate.username
        self.playerThreeLabel.text = object.teamTwo.teamCaptain.username
        self.playerFourLabel.text = object.teamTwo.teammate.username
        self.teamOneScore.text = String(object.teamOneScore)
        self.teamTwoScore.text = String(object.teamTwoScore)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        self.dateAndTimeLabel.text = dateFormatter.string(from: object.timeEnded!)
    }

}
