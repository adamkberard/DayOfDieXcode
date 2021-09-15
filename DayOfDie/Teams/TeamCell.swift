//
//  TeamTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/13/21.
//

import UIKit

class TeamCell: UITableViewCell {
    
    @IBOutlet weak var teammateUsernameLabel: UILabel!
    @IBOutlet weak var teamNameUsernameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    var team : Team? {
        didSet {
            teammateUsernameLabel.text = team!.teammate.username
            teamNameUsernameLabel.text = team!.teamName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
