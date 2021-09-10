//
//  GameDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/9/21.
//

import UIKit

class GameDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet var playerLabels: [UILabel]!
    @IBOutlet var scoreLabels: [UILabel]!
    @IBOutlet weak var pointsTableView: UITableView!
    
    var game : Game?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateTimeLabel.text = dateFormatter.string(from: game!.timeEnded!)
        playerLabels[0].text = game!.teamOne.teamCaptain.username
        playerLabels[1].text = game!.teamOne.teammate.username
        playerLabels[2].text = game!.teamTwo.teamCaptain.username
        playerLabels[3].text = game!.teamTwo.teammate.username
        scoreLabels[0].text = String(game!.teamOneScore)
        scoreLabels[1].text = String(game!.teamTwoScore)
        
        pointsTableView.delegate = self
        pointsTableView.dataSource = self
    }
    
    // MARK: Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game!.points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayerPointsCell"
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerPointsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PlayerPointsCell.")
        }
        cell.pointLabel.text = game!.points[indexPath.row].getString()
        
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
