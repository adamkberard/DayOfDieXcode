//
//  FriendTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit
import Alamofire

class FriendTableViewController: UITableViewController {
    
    var selectedFriend : Friend?
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFriend = userFriends[indexPath.row]
        self.performSegue(withIdentifier: "toFriendDetailView", sender: self)
    }
    
    func loadGames() {
        let headers: HTTPHeaders = [
            "Authorization": "Token \(currentUser.token)",
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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toFriendDetailView" {
                guard let viewController = segue.destination as? FriendDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.friend = selectedFriend
         }
     }
 }
    
    //MARK: Private Methods

    @objc func refresh(sender:AnyObject)
    {
        loadGames()
    }

}
