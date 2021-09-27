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
        
        self.playerOneLabel.textColor = ColorSettings.homeTeamColor
        self.playerTwoLabel.textColor = ColorSettings.homeTeamColor
        self.playerThreeLabel.textColor = ColorSettings.awayTeamColor
        self.playerFourLabel.textColor = ColorSettings.awayTeamColor
        
        self.playerOneLabel.text = object.homeTeam.teamCaptain.username
        self.playerTwoLabel.text = object.homeTeam.teammate.username
        self.playerThreeLabel.text = object.awayTeam.teamCaptain.username
        self.playerFourLabel.text = object.awayTeam.teammate.username
        
        self.teamOneScore.text = String(object.homeTeamScore)
        self.teamOneScore.textColor = ColorSettings.homeTeamColor
        self.teamTwoScore.text = String(object.teamTwoScore)
        self.teamTwoScore.textColor = ColorSettings.awayTeamColor
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        self.dateAndTimeLabel.text = dateFormatter.string(from: object.timeEnded!)
    }

}
