//
//  WaitingOnTetammateRequestTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import UIKit

class WaitingOnTeammateRequestTableViewCell: PlayerCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func cancelButtonPushed(_ sender: Any) {
        sendRequest(friendStatus: .NOTHING)
    }
}
