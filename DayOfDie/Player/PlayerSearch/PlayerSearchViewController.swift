//
//  AddFriendViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/29/21.
//

import UIKit

class PlayerSearchViewController: SearchTableViewController<Player> {
    
    override func setRawObjectList() -> [Player] { return PlayerSet.getAllPlayers() }
    override func setObjectList(rawList: [Player]) -> [Player] {
        PlayerSet.updateAllPlayers(playerList: rawList)
        return PlayerSet.getAllPlayers().filter { (player: Player) -> Bool in
            return player != User.player
        }
    }
    override func setCellIdentifiers() -> [String] { return ["PlayerCell"] }
    override func setTableSegueIdentifier() -> String { return "toPlayerDetail" }
    override func setFetchURLEnding() -> String { return "/player/" }
    override func setRefreshTitleString() -> String { return "Fetch Player Data..." }
    
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
