//
//  SpecialPointsViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/3/21.
//

import UIKit

class SpecialPointsViewController: UIViewController {

    // Player options
    @IBOutlet weak var tinkOptionOne: UILabel!
    @IBOutlet weak var tinkOptionTwo: UILabel!
    @IBOutlet weak var sinkOptionOne: UILabel!
    @IBOutlet weak var sinkOptionTwo: UILabel!
    @IBOutlet weak var bounceSinkOptionOne: UILabel!
    @IBOutlet weak var bounceSinkOptionTwo: UILabel!
    @IBOutlet weak var partnerSinkOption: UILabel!
    @IBOutlet weak var selfSinkOption: UILabel!
    
    // Point amounts
    @IBOutlet weak var tinkOptionOnePointsLabel: UILabel!
    @IBOutlet weak var tinkOptionTwoPointsLabel: UILabel!
    @IBOutlet weak var sinkOptionOnePointsLabel: UILabel!
    @IBOutlet weak var sinkOptionTwoPointsLabel: UILabel!
    @IBOutlet weak var bounceSinkOptionOnePointsLabel: UILabel!
    @IBOutlet weak var bounceSinkOptionTwoPointsLabel: UILabel!
    @IBOutlet weak var partnerSinkPointsLabel: UILabel!
    @IBOutlet weak var selfSinkPointsLabel: UILabel!
    
    @IBOutlet weak var playerTitleLabel: UILabel!
    
    var players : [PlayerData] = []
    var chosenPlayer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playerTitleLabel.text = "Special Points for \(players[chosenPlayer].name)"
        
        
    }
    
    @IBAction func tinkOptionOneMinusPressed(_ sender: Any) {
    }
    @IBAction func tinkOptionTwoMinusPressed(_ sender: Any) {
    }
    @IBAction func sinkOptionOneMinusPressed(_ sender: Any) {
    }
    @IBAction func sinkOptionTwoMinusPressed(_ sender: Any) {
    }
    @IBAction func bounceSinkOptionOneMinusPressed(_ sender: Any) {
    }
    @IBAction func bounceSinkOptionTwoMinusPressed(_ sender: Any) {
    }
    @IBAction func partnerMinusPressed(_ sender: Any) {
    }
    @IBAction func selfSinkMinusPressed(_ sender: Any) {
    }
    
    @IBAction func tinkOptionOnePlusPressed(_ sender: Any) {
    }
    @IBAction func tinkOptionTwoPlusPressed(_ sender: Any) {
    }
    @IBAction func sinkOptionOnePlusPressed(_ sender: Any) {
    }
    @IBAction func sinkOptionTwoPlusPressed(_ sender: Any) {
    }
    @IBAction func bounceSinkOptionOnePlusPressed(_ sender: Any) {
    }
    @IBAction func bounceSinkOptionTwoPlusPressed(_ sender: Any) {
    }
    @IBAction func partnerPlusPressed(_ sender: Any) {
    }
    @IBAction func selfSinkPlusPressed(_ sender: Any) {
    }
    
    func subtractOne(number: Int) -> Int{
        if(number > 0){
            return number - 1
        }
        else{
            return 0
        }
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
