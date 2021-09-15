//
//  FriendTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit
import Alamofire

class TeamTableViewController: UITableViewController {
    
    var selectedFriend : Team?
    
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
        return Team.approvedFriends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FriendTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TeamCell  else {
            fatalError("The dequeued cell is not an instance of TeamCell.")
        }
        
        // Fetches the appropriate friend for the data source layout.
        let team = Team.approvedFriends[indexPath.row]
        cell.team = team
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFriend = Team.approvedFriends[indexPath.row]
        self.performSegue(withIdentifier: "toFriendDetailView", sender: self)
    }
    
    func loadFriends() {
        APICalls.getFriends {status, returnData in
            if status{
                Team.allFriends = returnData as! [Team]
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
            if identifier == "toFriendDetailView" {
                guard let viewController = segue.destination as? TeamDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.team = selectedFriend
            }
        }
    }
    
    //MARK: Private Methods

    @objc func refresh(sender:AnyObject)
    {
        loadFriends()
    }

}
