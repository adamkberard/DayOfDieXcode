//
//  TeamTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit
import Alamofire

class TeamTableViewController: UITableViewController {
    
    var teamList : [Team] = []
    var selectedTeam : Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TeamCell", bundle: nil), forCellReuseIdentifier: "TeamCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return teamList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TeamCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TeamCell  else {
            fatalError("The dequeued cell is not an instance of TeamCell.")
        }
        
        let team = teamList[indexPath.row]
        cell.setupCell(team: team)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTeam = Team.approvedTeams[indexPath.row]
        self.performSegue(withIdentifier: "toTeamDetailView", sender: self)
    }
}
