//
//  AddFriendViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/29/21.
//

import UIKit

class PlayerSearchViewController: SearchTableViewController<Player> {
    
    override func viewDidLoad() {
        setObjectList()
        cellIdentifier = "PlayerCell"
        tableSegueIdentifier = "toPlayerDetail"
        fetchURLPostfix = "/players/"
        searchPlaceholderString = "Fetching Player Data..."
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setObjectList()
        tableView.reloadData()
    }
    
    func setObjectList() -> Void {
        objectList = Player.allPlayers.filter { (player: Player) -> Bool in
            return player != User.player
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toPlayerDetail" {
                guard let viewController = segue.destination as? PlayerViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.player = selectedObject
            }
        }
    }
}
