//
//  FriendRequestTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/28/21.
//

import UIKit

class FriendRequestTableViewController: UITableViewController {
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
            return Friend.pendingFriends.count
        }
        else {
            return Friend.waitingFriends.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendRequestCell", for: indexPath) as? PendingFriendRequestTableViewCell  else {
                fatalError("The dequeued cell is not an instance of PendingFriendRequestCell.")
            }
            cell.friend = Friend.pendingFriends[indexPath.row]
            cell.parentTableView = self.tableView
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "waitingFriendRequestCell", for: indexPath) as? WaitingFriendRequestTableViewCell  else {
                fatalError("The dequeued cell is not an instance of WaitingFriendRequestCell.")
            }
            cell.friend = Friend.waitingFriends[indexPath.row]
            cell.parentTableView = self.tableView
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
