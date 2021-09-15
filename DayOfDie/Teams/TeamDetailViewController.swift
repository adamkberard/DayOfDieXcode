//
//  FriendDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/24/21.
//

import UIKit

class TeamDetailViewController: UIViewController {
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    
    var team : Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        friendNameLabel.text = team!.getOtherUser().username
        winsLabel.text = String(team!.wins)
        lossesLabel.text = String(team!.losses)
    }
}
