//
//  StatsTableViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 8/12/21.
//

import UIKit

class StatsTableViewController: UITableViewController {
    
    var stats : [Statistic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        calcStats()
    }
    
    func calcStats(){
        stats = []
        var regularPoints : Int = 0
        var tinks : Int = 0
        var sinks : Int = 0
        var bounceSinks : Int = 0
        var partnerSinks : Int = 0
        var selfSinks : Int = 0
        var fifas : Int = 0
        var fieldGoals : Int = 0
        var fives : Int = 0
        var totalPoints : Int = 0
        
        // Not sure how I'm going to do it, but I'll start with totals of points
        for game in Game.allGames{
            for point in game.points{
                // For now we only care about points the user scored
                if point.scorer == LoggedInUser.user{
                    switch point.typeOfPoint {
                    case .REGULAR:
                        regularPoints += 1
                        totalPoints += 1
                    case .TINK:
                        tinks += 1
                        totalPoints += 2
                    case .SINK:
                        sinks += 1
                        totalPoints += 3
                    case .BOUNCE_SINK:
                        bounceSinks += 1
                        totalPoints += 2
                    case .PARTNER_SINK:
                        partnerSinks += 1
                    case .SELF_SINK:
                        selfSinks += 1
                    case .FIFA:
                        fifas += 1
                        totalPoints += 1
                    case .FIELD_GOAL:
                        fieldGoals += 1
                        totalPoints += 1
                    case .FIVE:
                        fives += 1
                    }
                }
            }
        }
        stats.append(Statistic(statName: "Total Points", statNumber: Double(totalPoints)))
        stats.append(Statistic(statName: "Regular Points", statNumber: Double(regularPoints)))
        stats.append(Statistic(statName: "Tinks", statNumber: Double(tinks)))
        stats.append(Statistic(statName: "Sinks", statNumber: Double(sinks)))
        stats.append(Statistic(statName: "Bounce Sinks", statNumber: Double(bounceSinks)))
        stats.append(Statistic(statName: "Partner Sinks", statNumber: Double(partnerSinks)))
        stats.append(Statistic(statName: "Self Sinks", statNumber: Double(selfSinks)))
        stats.append(Statistic(statName: "Fifas", statNumber: Double(fifas)))
        stats.append(Statistic(statName: "Field Goals", statNumber: Double(fieldGoals)))
        stats.append(Statistic(statName: "Fives", statNumber: Double(fives)))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stats.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "statCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StatTableViewCell  else {
            fatalError("The dequeued cell is not an instance of StatTableViewCell.")
        }
        
        // Fetches the appropriate game for the data source layout.
        let stat : Statistic = stats[indexPath.row]
        
        cell.statNameLabel.text = stat.statName
        cell.statNumberLabel.text = String(stat.statNumber)
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
