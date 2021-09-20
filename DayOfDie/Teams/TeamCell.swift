//
//  TeamTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/13/21.
//

import UIKit

class TeamCell: UITableViewCell {
    
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    var team : Team?
    
    func setupCell(team: Team) -> Void {
        self.team = team
        playerOneLabel.text = team.teamCaptain.username
        playerTwoLabel.text = team.teammate.username
        teamNameLabel.text = team.teamName
        winsLabel.text = String(team.wins)
        lossesLabel.text = String(team.losses)
    }
}
