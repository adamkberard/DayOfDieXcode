//
//  FriendRequestTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/28/21.
//

import UIKit

class FriendRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var friendRequestUsernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func acceptFriendRequestButtonPressed(_ sender: Any) {
        print("Accept \(friendRequestUsernameLabel.text)'s friend request.")
    }
    
    @IBAction func denyFriendRequestButtonPressed(_ sender: Any) {
        print("Deny \(friendRequestUsernameLabel.text)'s friend request.")
    }
}
