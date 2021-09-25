//
//  PlayerRequestCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/21/21.
//

import UIKit

class PlayerRequestCell: PlayerCell {
    
    var parentTableView : UITableViewController?
    
    func setupCell(player: Player, parentTableView: UITableViewController) {
        super.setupCell(object: player)
        self.parentTableView = parentTableView
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
                // Alert Stuff
                let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                self.parentTableView!.present(alert, animated: true)
            }
        }
    }
}
