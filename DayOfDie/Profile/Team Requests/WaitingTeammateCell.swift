//
//  WaitingOnTetammateRequestTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import UIKit

class WaitingTeammateCell: PlayerRequestCell {

    @IBAction func cancelButtonPushed(_ sender: Any) {
        sendRequest(friendStatus: .NOTHING)
    }
}
