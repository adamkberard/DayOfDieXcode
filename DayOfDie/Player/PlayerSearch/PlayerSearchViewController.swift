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
    
    private let myRefreshControl = UIRefreshControl()
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellReuseIdentifier: "PlayerCell")
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Players"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        tableView.refreshControl = myRefreshControl
        myRefreshControl.addTarget(self, action: #selector(refreshUserList(_:)), for: .valueChanged)
        myRefreshControl.attributedTitle = NSAttributedString(string: "Fetching Player Data...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setPlayerList()
        tableView.reloadData()
    }
    
    func setPlayerList() -> Void {
        playerList = Player.allPlayers.filter { (player: Player) -> Bool in
            return player != User.player
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredPlayerList = playerList.filter { (player: Player) -> Bool in
        return player.username.lowercased().contains(searchText.lowercased())
      }
      tableView.reloadData()
    }
    
    @objc func refreshUserList(_ sender: Any) {
        fetchUserData()
    }
    
    func fetchUserData() {
        // Loading all users here
        APICalls.getUsers {status, returnData in
            if status{
                Player.allPlayers = returnData as! [Player]
                self.setPlayerList()
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
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
        let cellIdentifier = "PlayerCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerCell  else {
            fatalError("The dequeued cell is not an instance of PlayerCell.")
        }
        
        if isFiltering {
            cell.setupCell(object: filteredPlayerList[indexPath.row])
        }
        else {
            cell.setupCell(object: playerList[indexPath.row])
        }
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
