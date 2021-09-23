//
//  GameDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/9/21.
//

import UIKit

class GameDetailViewController: BasePartialTableViewController<Point> {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet var scoreLabels: [UILabel]!
    @IBOutlet var playerButtons: [UIButton]!
    
    var game : Game!
    var selectedPlayer : Player?

    override func viewDidLoad() {
        tableObjectList = game.points
        cellIdentifier = "PointCell"
        super.viewDidLoad()
        setupView()
        tableView.refreshControl = nil
    }
    
    func setupView() -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateTimeLabel.text = dateFormatter.string(from: game!.timeEnded!)
        playerButtons[0].setTitle(game.teamOne.teamCaptain.username, for: .normal)
        playerButtons[1].setTitle(game.teamOne.teammate.username, for: .normal)
        playerButtons[2].setTitle(game.teamTwo.teamCaptain.username, for: .normal)
        playerButtons[3].setTitle(game.teamTwo.teammate.username, for: .normal)
        scoreLabels[0].text = String(game!.teamOneScore)
        scoreLabels[1].text = String(game!.teamTwoScore)
    }
    
    @IBAction func playerButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0: selectedPlayer = game.teamOne.teamCaptain
        case 1: selectedPlayer = game.teamOne.teammate
        case 2: selectedPlayer = game.teamTwo.teamCaptain
        case 3: selectedPlayer = game.teamTwo.teammate
        default: selectedPlayer = game.teamOne.teamCaptain
        }
        performSegue(withIdentifier: "toPlayerDetail", sender: self)
    }
    
    override func fetchObjectData() {}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toPlayerDetail" {
                guard let viewController = segue.destination as? PlayerViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.player = selectedPlayer
            }
        }
    }
}
