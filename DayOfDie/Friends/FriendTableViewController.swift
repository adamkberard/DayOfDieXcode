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
    var acceptedFriends : [Friend] = []
    var pendingFriends : [Friend] = []
    var nothingFriends : [Friend] = []
    
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
        parseFriends()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return acceptedFriends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FriendTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        
        // Fetches the appropriate friend for the data source layout.
        let friend = acceptedFriends[indexPath.row]
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
        selectedFriend = acceptedFriends[indexPath.row]
        self.performSegue(withIdentifier: "toFriendDetailView", sender: self)
    }
    
    func parseFriends() {
        acceptedFriends = []
        pendingFriends = []
        nothingFriends = []
        for friend in userFriends{
            if friend.status == .ACCEPTED {
                acceptedFriends.append(friend)
            }
            else if friend.status == .PENDING {
                pendingFriends.append(friend)
            }
            else if friend.status == .NOTHING {
                nothingFriends.append(friend)
            }
        }
    }
    
    func loadGames() {
        let headers: HTTPHeaders = [
            "Authorization": "Token \(currentUser.token)",
        ]
        
        AF.request("\(URLInfo.baseUrl)/friends/", method: .get, headers: headers).responseDecodable(of: [Friend].self) { response in
            switch response.result {
                case .success:
                    userFriends = response.value!
                    self.parseFriends()
                case let .failure(error):
                    print(error)
            }
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func requestsButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toFriendRequests", sender: self)
    }
    
    @IBAction func addFriendFriendButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddingFriend", sender: self)
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
            if identifier == "toFriendRequests" {
                guard let viewController = segue.destination as? FriendRequestTableViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                print("HELLOW \(pendingFriends.count)")
                viewController.pendingFriends = pendingFriends
            }
        }
    }
    
    //MARK: Private Methods

    @objc func refresh(sender:AnyObject)
    {
        loadGames()
    }

}
