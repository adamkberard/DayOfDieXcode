//
//  FriendTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit
import Alamofire

class FriendTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Refreshing stuff
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        // Loads the games
        loadGames()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userFriends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FriendTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        
        // Fetches the appropriate friend for the data source layout.
        let friend = userFriends[indexPath.row]
        print("FRIEND: \(friend.teamCaptain.username) ME: \(CurrentUser.username)")
        if friend.teamCaptain.username == currentUser.username{
            cell.friendUsernameLabel.text = friend.teammate.username
        }
        else{
            cell.friendUsernameLabel.text = friend.teamCaptain.username
        }
        if friend.teamname == nil {
            cell.teamNameLabel.text = " "
        }
        else{
            cell.teamNameLabel.text = friend.teamname
        }
        cell.winsLabel.text = String(friend.wins)
        cell.lossesLabel.text = String(friend.losses)
        
        return cell
    }
    
    func loadGames() {
        let headers: HTTPHeaders = [
            "Authorization": "Token \(CurrentUser.token)",
        ]
        
        AF.request("\(URLInfo.baseUrl)/friends/", method: .get, headers: headers).responseDecodable(of: [Friend].self) { response in
            switch response.result {
                case .success:
                    userFriends = response.value!
                case let .failure(error):
                    print(error)
            }
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods

    @objc func refresh(sender:AnyObject)
    {
        loadGames()
    }

}
