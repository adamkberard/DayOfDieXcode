//
//  UserViewConViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 8/6/21.
//

import UIKit
import Alamofire

class PlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var teamStatusLabel: UILabel!
    @IBOutlet weak var numberTeamsLabel: UILabel!
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    @IBOutlet weak var totalLossesLabel: UILabel!
    @IBOutlet weak var changeTeamStatusButton: UIButton!
    @IBOutlet weak var playerGamesTable: UITableView!
    
    var playerGames : [Game] = []
    var playerTeams : [Team] = []
    var selectedGame : Game?
    
    var player : Player?
    var changeTeamStatusOption : TeamStatuses?
    
    override func viewWillAppear(_ animated: Bool) {
        setUpView()
        fetchPlayerGameData()
        fetchPlayerTeamData()
    }
    
    func fetchPlayerGameData() {
        APICalls.getPlayerGames(player: player!) {status, returnData in
            if status{
                self.playerGames = returnData as! [Game]
                self.playerGamesTable.reloadData()
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
    
    func fetchPlayerTeamData() {
        APICalls.getPlayerTeams(player: player!) {status, returnData in
            if status{
                let allTeams = returnData as! [Team]
                self.playerTeams = allTeams.filter {(team: Team) -> Bool in
                    return team.status == .ACCEPTED
                }
                self.numberTeamsLabel.text = "Num Teams: \(self.playerTeams.count)"
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
    
    func setUpView() {
        playerGamesTable.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
        
        usernameLabel.text = player!.username
        totalWinsLabel.text = String(player!.wins)
        totalLossesLabel.text = String(player!.losses)
        totalGamesLabel.text = String(player!.wins + player!.losses)
        
        setTeamStatusLabelAndButton()
        
        playerGamesTable.delegate = self
        playerGamesTable.dataSource = self
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
    
    // MARK: Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(playerGames.count)
        return playerGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "GameTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GameTableViewCell  else {
            fatalError("The dequeued cell is not an instance of GameTableViewCell.")
        }
        
        // Fetches the appropriate game for the data source layout.
        let game = playerGames[indexPath.row]
        
        cell.playerOneLabel.text = game.teamOne.teamCaptain.username
        cell.playerTwoLabel.text = game.teamOne.teammate.username
        cell.playerThreeLabel.text = game.teamTwo.teamCaptain.username
        cell.playerFourLabel.text = game.teamTwo.teammate.username
        cell.teamOneScore.text = String(game.teamOneScore)
        cell.teamTwoScore.text = String(game.teamTwoScore)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        cell.dateAndTimeLabel.text = dateFormatter.string(from: game.timeEnded!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGame = playerGames[indexPath.row]
        self.performSegue(withIdentifier: "toGameDetail", sender: self)
    }
    
    @IBAction func seeTeamsButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toTeamList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toGameDetail" {
                guard let viewController = segue.destination as? GameDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.game = selectedGame
            }
            else if identifier == "toTeamList" {
                guard let viewController = segue.destination as? TeamTableViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.teamList = playerTeams
            }
        }
    }
}
