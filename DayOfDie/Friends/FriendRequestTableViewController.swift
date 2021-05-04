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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return CurrentUser.pendingFriends.count
        }
        else {
            return CurrentUser.waitingFriends.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendRequestCell", for: indexPath) as? PendingFriendRequestTableViewCell  else {
                fatalError("The dequeued cell is not an instance of FriendRequestTableViewCell.")
            }
            cell.friend = CurrentUser.pendingFriends[indexPath.row]
            cell.parentTableView = self.tableView
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "waitingFriendRequestCell", for: indexPath) as? WaitingFriendRequestTableViewCell  else {
                fatalError("The dequeued cell is not an instance of WaitingFriendRequestTableViewCell.")
            }
            cell.friend = CurrentUser.waitingFriends[indexPath.row]
            cell.parentTableView = self.tableView
            
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Pending"
        default:
            return "Waiting"
        }
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toHistoryFriends", sender: self)
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
