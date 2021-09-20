//
//  AddFriendViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/29/21.
//

import UIKit

class PlayerSearchViewController: UITableViewController, UISearchResultsUpdating {
    
    var playerList : [Player] = []
    var filteredPlayerList : [Player] = []
    let searchController = UISearchController(searchResultsController: nil)
    var selectedPlayer : Player?
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PlayerSearchCell", bundle: nil), forCellReuseIdentifier: "PlayerSearchCell")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Players"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playerList = Player.allPlayers.filter { (player: Player) -> Bool in
            return player != User.player
        }
        
        tableView.reloadData()
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredPlayerList = playerList.filter { (player: Player) -> Bool in
        return player.username.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }
    
    @objc func refreshUserData(_ sender: Any) {
        fetchUserData()
    }
    
    func fetchUserData() {
        // Loading all users here
        APICalls.getUsers {status, returnData in
            if status{
                Player.allPlayers = returnData as! [Player]
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPlayerList.count
        }
        return playerList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayerSearchCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerSearchCell  else {
            fatalError("The dequeued cell is not an instance of PlayerSearchCell.")
        }
        
        if isFiltering {
            cell.setUpCell(player: filteredPlayerList[indexPath.row])
        }
        else {
            cell.setUpCell(player: playerList[indexPath.row])
        }
        cell.parentTableView = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            selectedPlayer = filteredPlayerList[indexPath.row]
        }
        else {
            selectedPlayer = playerList[indexPath.row]
        }
        self.performSegue(withIdentifier: "toPlayerDetail", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toPlayerDetail" {
                guard let viewController = segue.destination as? PlayerViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.player = selectedPlayer
            }
        }
    }
}
