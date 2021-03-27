//
//  GameTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit
import Alamofire

class GameTableViewController: UITableViewController {
    
    var gameList : [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
         
        //loadGames()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gameList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "GameTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GameTableViewCell  else {
            fatalError("The dequeued cell is not an instance of GameTableViewCell.")
        }
        
        // Fetches the appropriate game for the data source layout.
        //let game = gameList[indexPath.row]
        
        /*cell.playerOneLabel.text = game.getPlayerOne().name
        cell.playerTwoLabel.text = game.getPlayerTwo().name
        cell.playerThreeLabel.text = game.getPlayerThree().name
        cell.playerFourLabel.text = game.getPlayerFour().name
        cell.teamOneScore.text = String(game.getTeamOneScore())
        cell.teamTwoScore.text = String(game.getTeamTwoScore())
        cell.dateAndTimeLabel.text = game.getSavedTimeString()*/
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods

    @objc func refresh(_ sender: UIRefreshControl) {
        //loadGames()
    }

}
