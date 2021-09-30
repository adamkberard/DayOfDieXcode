//
//  FriendDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/24/21.
//

import UIKit

class TeamDetailViewController: BaseTableViewController<Game>, UITextFieldDelegate {
    
    @IBOutlet weak var teamCaptainLabel: UILabel!
    @IBOutlet weak var teammateLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var changeTeamNameButton: UIButton!
    @IBOutlet weak var changeTeamTextField: UITextField!
    
    var team : Team?
    
    override func setRawObjectList() -> [Game] { return [] }
    override func setObjectList(rawList: [Game]) -> [Game] {
        for game in rawList {
            GameSet.setReferencedTeams(game: game)
            GameSet.setReferencedPlayerForPoints(game: game)
        }
        return rawList
    }
    override func setCellIdentifiers() -> [String] { return ["GameCell"] }
    override func setTableSegueIdentifier() -> String { return "toGameDetail" }
    override func setFetchURLEnding() -> String { return "/team/\(team!.uuid!.uuidString.lowercased())/games/" }
    override func setRefreshTitleString() -> String { return "Fetching Game Data..." }
    override func setTitleString() -> String { return team!.getTeamName() }

    override func setupView() {
        super.setupView()
        teamCaptainLabel.text = team!.teamCaptain.username
        teammateLabel.text = team!.teammate.username
        teamNameLabel.text = team!.getTeamName()
        winsLabel.text = String(team!.wins)
        lossesLabel.text = String(team!.losses)
        totalGamesLabel.text = String(team!.wins + team!.losses)
        
        if team?.teamCaptain == User.player || team?.teammate == User.player {
            changeTeamNameButton.isHidden = false
        } else {
            changeTeamNameButton.isHidden = true
        }
    }
    
    @IBAction func seeTeamsButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toTeamList", sender: self)
    }
    
    @IBAction func changeTeamNameButtonPressed(_ sender: Any) {
        if changeTeamTextField.isHidden {
            teamNameLabel.isHidden = true
            changeTeamTextField.isHidden = false
            changeTeamTextField.becomeFirstResponder()
        } else {
            changeTeamTextField.resignFirstResponder()
            let beforeTeamName : String = team!.getTeamName()
            let parameters : [String: Any] = ["team_name": changeTeamTextField.text as Any]
            APICalls.changeTeamName(parameters: parameters, team: team!) { status, returnData in
                if status{
                    let tempTeam = returnData as? Team
                    TeamSet.updateAllTeams(teamList: [tempTeam!])
                    self.team = TeamSet.getTeam(inTeam: tempTeam!)
                    
                    self.setupView()
                    self.tableView.reloadData()
                    self.myRefreshControl.endRefreshing()
                }
                else{
                    self.myRefreshControl.endRefreshing()
                    let errors : [String] = returnData as! [String]
                    // Alert Stuff
                    let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    // Change username back to before
                    self.teamNameLabel.text = beforeTeamName
                }
            }
            teamNameLabel.text = changeTeamTextField.text
            teamNameLabel.isHidden = false
            changeTeamTextField.isHidden = true
            changeTeamTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toGameDetail" {
                guard let viewController = segue.destination as? GameDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.game = selectedObject
            }
        }
    }
}
