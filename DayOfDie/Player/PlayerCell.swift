//
//  BaseFriendRequestTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 5/3/21.
//

import UIKit
import Alamofire

@IBDesignable
class PlayerCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    var player : Player?
    var parentTableView : UITableViewController?
    
    func setUpCell(player: Player) {
        self.player = player
        usernameLabel.text = player.username
        winsLabel.text = String(player.wins)
        lossesLabel.text = String(player.losses)
    }
    
    func sendRequest(friendStatus: TeamStatuses) {
        let parameters: [String: Any] = [
            "teammate": player!.username,
            "status": friendStatus.rawValue
        ]
        
        APICalls.sendFriend(parameters: parameters) { status, returnData in
            if status{
                let newTeam = (returnData as! Team)
                if let index = Team.allTeams.firstIndex(of: newTeam){
                    Team.allTeams.remove(at: index)
                }
                Team.allTeams.append(newTeam)
                self.parentTableView?.tableView.reloadData()
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
}
