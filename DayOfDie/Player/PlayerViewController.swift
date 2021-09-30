//
//  UserViewConViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 8/6/21.
//

import UIKit
import Alamofire

class PlayerViewController: BaseTableViewController<Game> {
    
    @IBOutlet weak var teamStatusLabel: UILabel!
    @IBOutlet weak var numberTeamsLabel: UILabel!
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    @IBOutlet weak var totalLossesLabel: UILabel!
    @IBOutlet weak var changeTeamStatusButton: UIButton!
    
    var playerTeams : [Team] = []
    
    var player : Player?
    var changeTeamStatusOption : TeamStatuses?
    
    override func setRawObjectList() -> [Game] { return rawObjectList }
    override func setObjectList(rawList: [Game]) -> [Game] {
        for game in rawList {
            GameSet.setReferencedTeams(game: game)
            GameSet.setReferencedPlayerForPoints(game: game)
        }
        return rawList
    }
    override func setCellIdentifiers() -> [String] { return ["GameCell"] }
    override func setTableSegueIdentifier() -> String { return "toGameDetail" }
    override func setFetchURLEnding() -> String { return "/player/\(player!.uuid)/games/" }
    override func setRefreshTitleString() -> String { return "Fetching Game Data..." }
    override func setTitleString() -> String { return player!.username }
    
    func fetchPlayerTeamData() {
        APICalls.getPlayerTeams(player: player!) {status, returnData in
            if status{
                self.playerTeams = returnData as! [Team]
                self.numberTeamsLabel.text = "Num Teams: \(self.playerTeams.count)"
            }
            else{
                self.myRefreshControl.endRefreshing()
                let errors : [String] = returnData as! [String]
                // Alert Stuff
                let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func setupView() {
        super.setupView()
        fetchPlayerTeamData()
        totalWinsLabel.text = String(player!.wins)
        totalLossesLabel.text = String(player!.losses)
        totalGamesLabel.text = String(player!.wins + player!.losses)
        
        setTeamStatusLabelAndButton()
    }
    
    func setTeamStatusLabelAndButton() {
        switch TeamSet.getTeamStatus(player: player!) {
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
            changeTeamStatusOption = .ACCEPTED
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
                TeamSet.updateAllTeams(teamList: [newTeam])
                self.setupView()
            }
            else{
                self.myRefreshControl.endRefreshing()
                let errors : [String] = returnData as! [String]
                // Alert Stuff
                let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                self.present(alert, animated: true)
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
                viewController.rawObjectList = playerTeams
            }
        }
    }
}
