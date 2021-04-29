//
//  AddFriendViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/29/21.
//

import UIKit

class AddFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var allUsersTable: UITableView!
    
    var otherUsernames : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        allUsersTable.delegate = self
        allUsersTable.dataSource = self
        
        removeCurrentFriendsAndSelf()
    }

    // MARK: Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherUsernames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "addFriendTableCell", for: indexPath) as? AddFriendTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AddFriendTableViewCell.")
        }
        cell.usernameLabel.text = otherUsernames[indexPath.row]
        
        return cell
    }
    
    private func removeCurrentFriendsAndSelf() {
        otherUsernames = allUsers
        
        for i in (0...otherUsernames.count-1).reversed() {
            if otherUsernames[i] == currentUser.username {
                otherUsernames.remove(at: i)
            }
            else{
                for friend in userFriends{
                    if otherUsernames[i] == friend.getOtherUser().username{
                        otherUsernames.remove(at: i)
                        break
                    }
                }
            }
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
