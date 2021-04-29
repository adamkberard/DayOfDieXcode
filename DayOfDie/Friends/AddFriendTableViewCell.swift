//
//  AddFriendTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/29/21.
//

import UIKit

// addFriendTableCell
class AddFriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sendRequestButtonPressed(_ sender: Any) {
        print("Sending a request to \(usernameLabel.text)")
    }
}
