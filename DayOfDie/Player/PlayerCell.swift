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
    var parentTableView : UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(player: Player) {
        self.player = player
        usernameLabel.text = player.username
        winsLabel.text = String(player.wins)
        lossesLabel.text = String(player.losses)
    }
    
    func sendRequest(friendStatus: FriendStatuses) {
        let parameters: [String: Any] = [
            "teammate": player!.username,
            "status": friendStatus.rawValue
        ]
        
        APICalls.sendFriend(parameters: parameters) { status, returnData in
            if status{
                let newTeam = (returnData as! Team)
                if let index = Team.allFriends.firstIndex(of: newTeam){
                    Team.allFriends.remove(at: index)
                }
                Team.allFriends.append(newTeam)
                self.parentTableView?.reloadData()
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
}
