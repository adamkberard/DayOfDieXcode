//
//  PlayerPointsTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/21/21.
//

import UIKit

class PlayerPointsTableViewController: UITableViewController {

    var points : [Point] = []
    var mainTrackingViewController : TrackingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return points.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayerPointsCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerPointsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PlayerPointsCell.")
        }
        
        // Fetches the appropriate game for the data source layout.
        let point = points[indexPath.row]
        cell.pointLabel.text = point.getString()
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            points.remove(at: indexPath.row)
            let playerNumber = mainTrackingViewController!.currentlyPickedPoints
            mainTrackingViewController!.trackerComponents[playerNumber].points = points
            tableView.deleteRows(at: [indexPath], with: .fade)
            mainTrackingViewController?.pointsDidChange()
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
      return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = points.remove(at: sourceIndexPath.row)
        points.insert(temp, at: destinationIndexPath.row)
        let playerNumber = mainTrackingViewController!.currentlyPickedPoints
        mainTrackingViewController!.trackerComponents[playerNumber].points = points
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        // Takes care of toggling the button's title.
        super.setEditing(editing, animated: true)

        // Toggle table view editing.
        tableView.setEditing(editing, animated: true)
    }
    
}
