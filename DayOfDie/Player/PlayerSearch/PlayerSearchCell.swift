//
//  UserSearchCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import UIKit

@IBDesignable
class PlayerSearchCell: PlayerCell {

    @IBOutlet weak var changeTeamStatusButton: UIButton!
    var changeTeamStatusOption : TeamStatuses?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func changeTeammateStatusPressed(_ sender: UIButton) {
        sendRequest(friendStatus: changeTeamStatusOption!)
    }
    
    override func setUpCell(player: Player) {
        super.setUpCell(player: player)
        
        switch Team.getTeamStatus(player: player) {
        case .ACCEPTED:
            changeTeamStatusButton.setTitle("Disband Team", for: .normal)
            changeTeamStatusOption = .NOTHING
        case .WAITING:
            changeTeamStatusButton.setTitle("Cancel Request", for: .normal)
            changeTeamStatusOption = .NOTHING
        case .PENDING:
            changeTeamStatusButton.setTitle("Accept Request", for: .normal)
            changeTeamStatusOption = .ACCEPTED
        case .NOTHING:
            if player == User.player {
                changeTeamStatusButton.isEnabled = false
                changeTeamStatusButton.setTitle("This is You", for: .disabled)
            }
            else{
                changeTeamStatusButton.setTitle("Send Request", for: .normal)
                changeTeamStatusOption = .ACCEPTED
            }
        default:
            changeTeamStatusOption = .NOTHING
        }
    }
}
