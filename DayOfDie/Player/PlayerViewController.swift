//
//  UserViewConViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 8/6/21.
//

import UIKit
import Alamofire

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var teamStatusLabel: UILabel!
    @IBOutlet weak var numberTeamsLabel: UILabel!
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    @IBOutlet weak var totalLossesLabel: UILabel!
    @IBOutlet weak var changeTeamStatusButton: UIButton!
    
    var player : Player?
    var changeTeamStatusOption : FriendStatuses?
    
    
    func setUpView() {
        usernameLabel.text = player!.username
        totalWinsLabel.text = String(player!.wins)
        totalLossesLabel.text = String(player!.losses)
        totalGamesLabel.text = String(player!.wins + player!.losses)
        
        setTeamStatusLabelAndButton()
    }
    
    func setTeamStatusLabelAndButton() {
        switch Team.getFriendStatus(player: player!) {
        case .ACCEPTED:
            teamStatusLabel.text = "Friends"
            changeTeamStatusButton.setTitle("Unfriend", for: .normal)
            changeTeamStatusOption = .NOTHING
        case .WAITING:
            teamStatusLabel.text = "Waiting"
            changeTeamStatusButton.setTitle("Cancel Request", for: .normal)
            changeTeamStatusOption = .NOTHING
        case .PENDING:
            teamStatusLabel.text = "Pending"
            changeTeamStatusButton.setTitle("Accept", for: .normal)
        case .NOTHING:
            teamStatusLabel.text  = "Nothing"
            changeTeamStatusButton.setTitle("Send Request", for: .normal)
            changeTeamStatusOption = .ACCEPTED
        default:
            teamStatusLabel.text = "Default"
            changeTeamStatusOption = .NOTHING
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()      
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpView()
    }
    
    @IBAction func changeTeamStatusButtonPressed(_ sender: Any) {
        let parameters: [String: Any] = [
            "teammate": player!.username,
            "status": changeTeamStatusOption!.rawValue
        ]
        
        APICalls.sendFriend(parameters: parameters) { status, returnData in
            if status{
                let newTeam = (returnData as! Team)
                if let index = Team.allFriends.firstIndex(of: newTeam){
                    Team.allFriends.remove(at: index)
                }
                Team.allFriends.append(newTeam)
                self.player = newTeam.getOtherUser()
                self.setUpView()
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
    
}
