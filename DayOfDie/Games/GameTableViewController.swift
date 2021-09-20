//
//  GameTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit
import Alamofire

class GameTableViewController: UITableViewController {
    
    var selectedGame : Game?
    
    var needToGoToLastGame : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // Refreshing stuff
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        // Loads the games
        // loadGames()        
    }
    override func viewDidAppear(_ animated: Bool) {
        if needToGoToLastGame {
            tableView.selectRow(at: IndexPath(row: Game.allGames.count - 1, section: 0), animated: true, scrollPosition: .bottom)
            selectedGame = Game.allGames.last
            self.performSegue(withIdentifier: "toGameDetail", sender: self)
            needToGoToLastGame = false
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.allGames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "GameTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GameTableViewCell  else {
            fatalError("The dequeued cell is not an instance of GameTableViewCell.")
        }
        
        // Fetches the appropriate game for the data source layout.
        let game = Game.allGames[indexPath.row]
        
        cell.playerOneLabel.text = game.teamOne.teamCaptain.username
        cell.playerTwoLabel.text = game.teamOne.teammate.username
        cell.playerThreeLabel.text = game.teamTwo.teamCaptain.username
        cell.playerFourLabel.text = game.teamTwo.teammate.username
        cell.teamOneScore.text = String(game.teamOneScore)
        cell.teamTwoScore.text = String(game.teamTwoScore)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        cell.dateAndTimeLabel.text = dateFormatter.string(from: game.timeEnded!)
        
        return cell
    }
    
    func loadGames() {
        APICalls.getGames {status, returnData in
            if status{
                // Check if everything is done if so move on
                Game.allGames = returnData as! [Game]
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGame = Game.allGames[indexPath.row]
        self.performSegue(withIdentifier: "toGameDetail", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toGameDetail" {
                guard let viewController = segue.destination as? GameDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.game = selectedGame
            }
        }
    }
    
    //MARK: Private Methods

    @objc func refresh(sender:AnyObject)
    {
        loadGames()
    }

}
