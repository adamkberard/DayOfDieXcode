//
//  TeamTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit
import Alamofire

@IBDesignable
class PlayerTeamsTableViewController: BaseTableViewController<Team> {
    
    var player : Player!
    
    override func setRawObjectList() -> [Team] { return rawObjectList }
    override func setObjectList(rawList: [Team]) -> [Team] {
        for team in rawList {
            TeamSet.setReferencedPlayers(team: team)
        }
        return rawList
    }
    override func setCellIdentifiers() -> [String] { return ["TeamCell"] }
    override func setTableSegueIdentifier() -> String { return "toTeamDetail" }
    override func setFetchURLEnding() -> String { return "/player/\(player.uuid)/teams/" }
    override func setRefreshTitleString() -> String { return "Fetching Team Data..." }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toTeamDetail" {
                guard let viewController = segue.destination as? TeamDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.team = selectedObject
            }
        }
    }
}
