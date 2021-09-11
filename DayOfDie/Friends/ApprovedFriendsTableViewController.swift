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
        
        // Refreshing stuff
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        loadFriends()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Friend.approvedFriends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FriendTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FriendTableViewCell.")
        }
        
        // Fetches the appropriate friend for the data source layout.
        let friend = Friend.approvedFriends[indexPath.row]
        cell.friendUsernameLabel.text = friend.getOtherUser().username
        cell.winsLabel.text = String(friend.wins)
        cell.lossesLabel.text = String(friend.losses)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFriend = Friend.approvedFriends[indexPath.row]
        self.performSegue(withIdentifier: "toFriendDetailView", sender: self)
    }
    
    func loadFriends() {
        APICalls.getFriends {status, returnData in
            if status{
                print(Friend.allFriends.count)
                Friend.allFriends = returnData as! [Friend]
                print(Friend.allFriends.count)
            }
            else{
                //Handle if things go wrong
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
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
        }
    }
    
    //MARK: Private Methods

    @objc func refresh(sender:AnyObject)
    {
        loadFriends()
    }

}
