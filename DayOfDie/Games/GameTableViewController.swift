//
//  GameTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit
import Alamofire

class GameTableViewController: BaseTableViewController<Game> {
    
    var needToGoToLastGame : Bool = false

    //MARK: View Functions
    override func viewDidLoad() {
        cellIdentifier = "GameCell"
        tableSegueIdentifier = "toGameDetail"
        fetchURLPostfix = "/games/"
        refreshTitleString = "Fetching Game Data..."
        objectList = Game.allGames
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if needToGoToLastGame {
            tableView.selectRow(at: IndexPath(row: Game.allGames.count - 1, section: 0), animated: true, scrollPosition: .bottom)
            selectedObject = Game.allGames.last
            self.performSegue(withIdentifier: "toGameDetail", sender: self)
            needToGoToLastGame = false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toGameDetail" {
                guard let viewController = segue.destination as? GameDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.game = selectedObject
            }
        }
    }
}
