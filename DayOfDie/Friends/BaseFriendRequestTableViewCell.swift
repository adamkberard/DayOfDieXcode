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
        let headers: HTTPHeaders = [
            "Authorization": "Token \(CurrentUser.token)",
        ]
        
        let parameters: [String: Any] = [
            "teammate": friend!.getOtherUser().username
        ]
        
        AF.request("\(URLInfo.baseUrl)/friends/", method: .post, parameters: parameters, headers: headers).responseDecodable(of: Friend.self) { response in
            print()
            switch response.result {
                case .success:
                    if let index = CurrentUser.friends.firstIndex(of: self.friend!){
                        CurrentUser.friends.remove(at: index)
                    }
                    
                    CurrentUser.friends.append(response.value!)
                    self.parentTableView?.reloadData()
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    @IBAction func secondButtonPressed(_ sender: Any) {
        let headers: HTTPHeaders = [
            "Authorization": "Token \(CurrentUser.token)",
        ]
        
        let parameters: [String: Any] = [
            "teammate": friend!.getOtherUser().username,
            "status": FriendStatuses.DENIED.rawValue
        ]
        
        AF.request("\(URLInfo.baseUrl)/friends/", method: .post, parameters: parameters, headers: headers).responseDecodable(of: Friend.self) { response in
            print()
            switch response.result {
                case .success:
                    if let index = CurrentUser.friends.firstIndex(of: self.friend!) {
                        CurrentUser.friends.remove(at: index)
                    }
                    CurrentUser.friends.append(response.value!)
                    self.parentTableView?.reloadData()
                case let .failure(error):
                    print(error)
            }
        }
    }
}

class PendingFriendRequestTableViewCell: BaseFriendRequestTableViewCell {
}

class HistoryFriendTableViewCell: BaseFriendRequestTableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstButton.setTitle("Send Request", for: .normal)
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
