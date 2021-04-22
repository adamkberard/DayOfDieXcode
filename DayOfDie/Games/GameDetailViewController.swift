//
//  GameDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 4/9/21.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet var playerLabels: [UILabel]!
    @IBOutlet var scoreLabels: [UILabel]!
    var game : Game?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dateTimeLabel.text = game!.timeEnded
        playerLabels[0].text = game!.teamOne.teamCaptain.username
        playerLabels[1].text = game!.teamOne.teammate.username
        playerLabels[2].text = game!.teamTwo.teamCaptain.username
        playerLabels[3].text = game!.teamTwo.teammate.username
        scoreLabels[0].text = String(game!.teamOneScore)
        scoreLabels[1].text = String(game!.teamTwoScore)
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
