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
    
    override func setRawObjectList() -> [Game] { return GameSet.getAllGames() }
    override func setCellIdentifiers() -> [String] { return ["GameCell"] }
    override func setTableSegueIdentifier() -> String { return "toGameDetail" }
    override func setFetchURLEnding() -> String { return "/game/" }
    override func setRefreshTitleString() -> String { return "Fetch Game Data..." }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if needToGoToLastGame {
            tableView.selectRow(at: IndexPath(row: GameSet.getAllGames().count - 1, section: 0), animated: true, scrollPosition: .bottom)
            selectedObject = GameSet.getAllGames().last
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
