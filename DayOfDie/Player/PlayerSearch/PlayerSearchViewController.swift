//
//  AddFriendViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/29/21.
//

import UIKit

class PlayerSearchViewController: SearchTableViewController<Player> {
    
    override func setRawObjectList() -> [Player] { return Player.allPlayers }
    override func setObjectList(rawList: [Player]) -> [Player] {
        Player.allPlayers = rawList
        return rawList.filter { (player: Player) -> Bool in
            return player != User.player
        }
    }
    override func setCellIdentifiers() -> [String] { return ["PlayerCell"] }
    override func setTableSegueIdentifier() -> String { return "toPlayerDetail" }
    override func setFetchURLEnding() -> String { return "/players/" }
    override func setRefreshTitleString() -> String { "Fetch Player Data..." }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toPlayerDetail" {
                guard let viewController = segue.destination as? PlayerViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.player = selectedObject
            }
        }
    }
}
