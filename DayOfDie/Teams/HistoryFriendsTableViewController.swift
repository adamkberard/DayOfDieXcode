//
//  HistoryFriendsTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 5/3/21.
//

import UIKit

class HistoryFriendsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentUser.nothingFriends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addHistoryTableCell", for: indexPath) as? HistoryFriendTableViewCell  else {
         fatalError("The dequeued cell is not an instance of FriendRequestTableViewCell.")
        }
        cell.friend = CurrentUser.nothingFriends[indexPath.row]
        cell.parentTableView = self.tableView
     
        return cell
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
