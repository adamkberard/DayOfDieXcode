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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data sourcew
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // The first section will be the waiting requests
    // The second section will be the pending requests
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Team.pendingTeams.count
        }
        else {
            return Team.waitingTeams.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendRequestCell", for: indexPath) as? PendingTeammateRequestTableViewCell  else {
                fatalError("The dequeued cell is not an instance of PendingFriendRequestCell.")
            }
            let player = Team.pendingTeams[indexPath.row].getOtherUser()
            cell.player = player
            cell.parentTableView = self
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "waitingFriendRequestCell", for: indexPath) as? WaitingOnTeammateRequestTableViewCell else {
                fatalError("The dequeued cell is not an instance of WaitingFriendRequestCell.")
            }
            let player = Team.pendingTeams[indexPath.row].getOtherUser()
            cell.player = player
            cell.parentTableView = self
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
