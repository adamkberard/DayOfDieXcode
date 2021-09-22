//
//  PendingTeammateRequestTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import UIKit

class PendingTeammateCell: PlayerRequestCell {

    @IBAction func acceptButtonPressed(_ sender: Any) {
        sendRequest(friendStatus: .ACCEPTED)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        sendRequest(friendStatus: .NOTHING)
    }
}
