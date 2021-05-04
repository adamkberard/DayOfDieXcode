//
//  AddUserTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 5/3/21.
//

import UIKit

class AddUserTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var friends : [Friend] = []
    var parentView : AddFriendViewController?
    
    override func reloadData() {
        loadData()
        super.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadData()
    }
    
    func loadData() {
        var usernames = allUsers
        friends = []
        
        // Filtering first
        for i in (0...usernames.count-1).reversed() {
            if !usernames[i].starts(with: parentView?.searchBar.text ?? ""){
                usernames.remove(at: i)
            }
        }
        
        // Taking out my own name
        for i in (0...usernames.count-1).reversed() {
            if usernames[i] == CurrentUser.username{
                usernames.remove(at: i)
            }
        }
        
        // Taking out people I have as active, pending, or waiting
        for i in (0...usernames.count-1).reversed() {
            for friend in CurrentUser.friends{
                if friend.status != .NOTHING && friend.getOtherUser().username == usernames[i]{
                    usernames.remove(at: i)
                    break
                }
            }
        }
        
        // Creating friends
        for username in usernames{
            friends.append(Friend.findOrCreateFriend(teamCaptain: CurrentUser.basicUser, teammate: BasicUser(username: username)))
        }
    }
    
    // MARK: Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addFriendTableCell", for: indexPath) as? AddFriendTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AddFriendTableViewCell.")
        }
        
        cell.friend = friends[indexPath.row]
        cell.parentTableView = self
        
        return cell
    }

}
