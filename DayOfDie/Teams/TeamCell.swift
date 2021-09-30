//
//  TeamTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/13/21.
//

import UIKit

@IBDesignable
class TeamCell: BaseTableViewCell<Team> {
    
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    var team: Team!
    
    override func setupCell(object: Team) -> Void {
        self.team = object
        playerOneLabel.text = team.teamCaptain.username
        playerTwoLabel.text = team.teammate.username
        teamNameLabel.text = team.getTeamName()
        winsLabel.text = String(team.wins)
        lossesLabel.text = String(team.losses)
    }
}
