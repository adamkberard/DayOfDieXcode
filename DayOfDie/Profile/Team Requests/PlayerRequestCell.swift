//
//  PlayerRequestCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/21/21.
//

import UIKit

class PlayerRequestCell: PlayerCell {
    
    var parentTableView : BaseTableViewController<Team>?
    
    func setupCell(player: Player, parentTableView: BaseTableViewController<Team>) {
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
                TeamSet.updateAllTeams(teamList: [newTeam])
                self.parentTableView?.tableView.reloadData()
            }
            else{
                let errors : [String] = returnData as! [String]
                // Alert Stuff
                let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                self.parentTableView!.present(alert, animated: true)
            }
        }
    }
}
