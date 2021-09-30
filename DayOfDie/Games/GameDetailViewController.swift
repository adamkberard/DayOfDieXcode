//
//  GameDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/9/21.
//

import UIKit

class GameDetailViewController: BaseTableViewController<Point> {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet var scoreLabels: [UILabel]!
    @IBOutlet var playerButtons: [UIButton]!
    
    var game : Game!
    var selectedPlayer : Player?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = nil
    }
    
    override func setRawObjectList() -> [Point] { return game.points }
    override func setObjectList(rawList: [Point]) -> [Point] { return rawList }
    override func setCellIdentifiers() -> [String] { return ["PointCell"] }
    
    override func setupView() -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateTimeLabel.text = dateFormatter.string(from: game!.timeEnded!)
        playerButtons[0].setTitle(game.homeTeam.teamCaptain.username, for: .normal)
        playerButtons[1].setTitle(game.homeTeam.teammate.username, for: .normal)
        playerButtons[2].setTitle(game.awayTeam.teamCaptain.username, for: .normal)
        playerButtons[3].setTitle(game.awayTeam.teammate.username, for: .normal)
        scoreLabels[0].text = String(game!.homeTeamScore)
        scoreLabels[1].text = String(game!.awayTeamScore)
    }
    
    @IBAction func playerButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0: selectedPlayer = game.homeTeam.teamCaptain
        case 1: selectedPlayer = game.homeTeam.teammate
        case 2: selectedPlayer = game.awayTeam.teamCaptain
        case 3: selectedPlayer = game.awayTeam.teammate
        default: selectedPlayer = game.homeTeam.teamCaptain
        }
        performSegue(withIdentifier: "toPlayerDetail", sender: self)
    }
    
    override func fetchObjectData() {}
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = super.tableView(tableView, cellForRowAt: indexPath) as? PointCell else {
            fatalError("The dequeued cell is not an instance of PointCell.")
        }
        if game.isOnHomeTeam(player: cell.point.scorer){
            cell.pointLabel.textColor = ColorSettings.homeTeamColor
        } else {
            cell.pointLabel.textColor = ColorSettings.awayTeamColor
        }
        return cell
    }
    
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
