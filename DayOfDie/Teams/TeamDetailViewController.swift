//
//  FriendDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/24/21.
//

import UIKit

class TeamDetailViewController: BaseTableViewController<Game> {
    
    @IBOutlet weak var teamCaptainLabel: UILabel!
    @IBOutlet weak var teammateLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var lossesLabel: UILabel!
    @IBOutlet weak var totalGamesLabel: UILabel!
    
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
        
        winsLabel.text = String(team!.wins)
        lossesLabel.text = String(team!.losses)
        totalGamesLabel.text = String(team!.wins + team!.losses)
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
        }
    }
}
