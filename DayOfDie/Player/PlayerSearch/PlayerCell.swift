//
//  BaseFriendRequestTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 5/3/21.
//

import UIKit
import Alamofire

@IBDesignable
class PlayerCell: BaseTableViewCell<Player> {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    var player : Player!
    
    override func setupCell(object: Player) {
        self.player = object
        usernameLabel.text = object.username
        winsLabel.text = String(object.wins)
        lossesLabel.text = String(object.losses)
    }
}
