//
//  FriendRequestTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/28/21.
//

import UIKit

class TeamRequestTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "WaitingTeammateCell", bundle: nil), forCellReuseIdentifier: "WaitingTeammateCell")
        tableView.register(UINib(nibName: "PendingTeammateCell", bundle: nil), forCellReuseIdentifier: "PendingTeammateCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data sourcew
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // The first section will be the waiting requests
    // The second section will be the pending requests
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Team.pendingTeammates.count
        }
        else {
            return Team.waitingTeammates.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PendingTeammateCell", for: indexPath) as? PendingTeammateCell  else {
                fatalError("The dequeued cell is not an instance of PendingPlayerCell.")
            }
            let player = Team.pendingTeammates[indexPath.row]
            cell.setupCell(player: player, parentTableView: self)
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WaitingTeammateCell", for: indexPath) as? WaitingTeammateCell  else {
                fatalError("The dequeued cell is not an instance of WaitingTeammateCell.")
            }
            let player = Team.waitingTeammates[indexPath.row]
            cell.setupCell(player: player, parentTableView: self)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pending"
        }
        else {
            return "Waiting"
        }
    }
}
