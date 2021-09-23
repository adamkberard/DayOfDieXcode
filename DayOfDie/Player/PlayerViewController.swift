//
//  UserViewConViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 8/6/21.
//

import UIKit
import Alamofire

class PlayerViewController: BasePartialTableViewController<Game> {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var teamStatusLabel: UILabel!
    @IBOutlet weak var numberTeamsLabel: UILabel!
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    @IBOutlet weak var totalLossesLabel: UILabel!
    @IBOutlet weak var changeTeamStatusButton: UIButton!
    
    var playerTeams : [Team] = []
    
    var player : Player?
    var changeTeamStatusOption : TeamStatuses?
    
    override func viewDidLoad() {
        cellIdentifier = "GameCell"
        tableSegueIdentifier = "toGameDetail"
        refreshTitleString = "Fetching Game Data..."
        super.viewDidLoad()
        fetchURLPostfix = "/games/\(player!.username)/"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        setUpView()
        fetchPlayerTeamData()
    }
    
    func fetchPlayerTeamData() {
        APICalls.getPlayerTeams(player: player!) {status, returnData in
            if status{
                self.playerTeams = returnData as! [Team]
                self.numberTeamsLabel.text = "Num Teams: \(self.playerTeams.count)"
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
    
    func setUpView() {
        usernameLabel.text = player!.username
        totalWinsLabel.text = String(player!.wins)
        totalLossesLabel.text = String(player!.losses)
        totalGamesLabel.text = String(player!.wins + player!.losses)
        
        setTeamStatusLabelAndButton()
    }
    
    func setTeamStatusLabelAndButton() {
        switch Team.getTeamStatus(player: player!) {
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

    @IBAction func changeTeamStatusButtonPressed(_ sender: Any) {
        let parameters: [String: Any] = [
            "teammate": player!.username,
            "status": changeTeamStatusOption!.rawValue
        ]
        
        APICalls.sendFriend(parameters: parameters) { status, returnData in
            if status{
                let newTeam = (returnData as! Team)
                if let index = Team.allTeams.firstIndex(of: newTeam){
                    Team.allTeams.remove(at: index)
                }
                Team.allTeams.append(newTeam)
                self.player = newTeam.getOtherUser()
                self.setUpView()
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
    
    @IBAction func seeTeamsButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toTeamList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toGameDetail" {
                guard let viewController = segue.destination as? GameDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.game = selectedObject
            }
            else if identifier == "toTeamList" {
                guard let viewController = segue.destination as? PlayerTeamsTableViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.player = player
                viewController.objectList = playerTeams
            }
        }
    }
}
