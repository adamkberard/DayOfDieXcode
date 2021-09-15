//
//  UserSearchCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import UIKit

class PlayerSearchCell: PlayerCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addAsTeammateButtonPressed(_ sender: Any) {
        sendRequest(friendStatus: .ACCEPTED)
    }
}
