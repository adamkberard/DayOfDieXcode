//
//  PendingTeammateRequestTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import UIKit

class PendingTeammateRequestTableViewCell: PlayerCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func acceptButtonPressed(_ sender: Any) {
        sendRequest(friendStatus: .ACCEPTED)
    }
}
