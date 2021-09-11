//
//  BaseFriendRequestTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 5/3/21.
//

import UIKit
import Alamofire

@IBDesignable
class BaseFriendRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var winsLossesStackView: UIStackView!
    
    var friend : Friend? {
        didSet {
            usernameLabel.text = friend!.getOtherUser().username
            winsLabel.text = String(friend!.wins)
            lossesLabel.text = String(friend!.losses)
        }
    }
    var parentTableView : UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func firstButtonPressed(_ sender: Any) {
        let parameters: [String: Any] = [
            "teammate": friend!.getOtherUser().username,
            "status": FriendStatuses.ACCEPTED.rawValue
        ]
        
        APICalls.sendFriend(parameters: parameters) { status, returnData in
            if status{
                // Check if everything is done if so move on
                self.friend = (returnData as! Friend)
                if let index = Friend.allFriends.firstIndex(of: self.friend!){
                    print("REplaceing friend")
                    Friend.allFriends.remove(at: index)
                }
                Friend.allFriends.append(self.friend!)
                self.parentTableView?.reloadData()
            }
            else{
                //Handle if things go wrong
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
    
    @IBAction func secondButtonPressed(_ sender: Any) {
        
        let parameters: [String: Any] = [
            "teammate": friend!.getOtherUser().username,
            "status": FriendStatuses.NOTHING.rawValue
        ]
        APICalls.sendFriend(parameters: parameters) { status, returnData in
            if status{
                // Check if everything is done if so move on
                self.friend = (returnData as! Friend)
                if let index = Friend.allFriends.firstIndex(of: self.friend!){
                    Friend.allFriends.remove(at: index)
                }
                Friend.allFriends.append(self.friend!)
                self.parentTableView?.reloadData()
            }
            else{
                //Handle if things go wrong
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
}

class PendingFriendRequestTableViewCell: BaseFriendRequestTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstButton.setTitle("Accept", for: .normal)
        secondButton.isHidden = true
    }
}

class WaitingFriendRequestTableViewCell: BaseFriendRequestTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstButton.isHidden = true
        secondButton.setTitle("Cancel", for: .normal)
    }
}

class AddFriendTableViewCell: BaseFriendRequestTableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstButton.setTitle("Send Request", for: .normal)
        secondButton.isHidden = true
    }
    
}

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendUsernameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
