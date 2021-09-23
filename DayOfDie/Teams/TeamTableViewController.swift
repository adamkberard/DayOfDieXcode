//
//  TeamTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit
import Alamofire

class TeamTableViewController: BaseTableViewController<Team> {
    
    var player : Player!
    
    override func viewDidLoad() {
        cellIdentifier = "TeamCell"
        tableSegueIdentifier = "toTeamDetail"
        fetchURLPostfix = "/teams/\(player.username)/"
        refreshTitleString = "Fetching Team Data..."
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toTeamDetail" {
                guard let viewController = segue.destination as? TeamDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.team = selectedObject
            }
        }
    }
}
