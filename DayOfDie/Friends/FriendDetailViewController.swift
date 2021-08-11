//
//  FriendDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/24/21.
//

import UIKit

class FriendDetailViewController: UIViewController {
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    var friend : Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        friendNameLabel.text = friend!.getOtherUser().username
        winsLabel.text = String(friend!.wins)
        lossesLabel.text = String(friend!.losses)
    }
}
