//
//  FriendRequestTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/28/21.
//

import UIKit

class TeamRequestTableViewController: BaseTableViewController<Team> {
    
    override func setRawObjectList() -> [Team] { return TeamSet.getAllTeams() }
    override func setObjectList(rawList: [Team]) -> [Team] {
        return rawList
    }
    override func setCellIdentifiers() -> [String] { return ["WaitingTeammateCell", "PendingTeammateCell"] }
    override func setTableSegueIdentifier() -> String { return "" }
    override func setFetchURLEnding() -> String { return "/team/" }
    override func setRefreshTitleString() -> String { return "Fetching Team Data..." }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            print("pending")
            return "Pending"
        }
        else {
            print("waiting")
            return "Waiting"
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // The first section will be the pending requests
    // The second section will be the waiting requests
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return TeamSet.pendingTeammates.count
        }
        else {
            return TeamSet.waitingTeammates.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PendingTeammateCell", for: indexPath) as? PendingTeammateCell  else {
                fatalError("The dequeued cell is not an instance of PendingPlayerCell.")
            }
            let player = TeamSet.pendingTeammates[indexPath.row]
            cell.setupCell(player: player, parentTableView: self)
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WaitingTeammateCell", for: indexPath) as? WaitingTeammateCell  else {
                fatalError("The dequeued cell is not an instance of WaitingTeammateCell.")
            }
            let player = TeamSet.waitingTeammates[indexPath.row]
            cell.setupCell(player: player, parentTableView: self)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
