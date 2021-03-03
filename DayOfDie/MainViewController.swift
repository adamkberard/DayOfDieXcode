//
//  ViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/2/21.
//

import UIKit

struct PlayerLabels {
    var tableLabel: UILabel
    var pointsNameLabel: UILabel
    var bigPointsLabel: UILabel
    var pointsLabel: UILabel
    var tinksLabel: UILabel
    var sinksLabel: UILabel
    var bounceSinksLabel: UILabel
    var partnerSinksLabel: UILabel
    var selfSinksLabel: UILabel
}

struct PlayerData {
    var playerNumber = 0
    var name : String = ""
    var points : Int = 0
    var tinks : [String] = []
    var sinks : [String] = []
    var bounceSinks : [String] = []
    var partnerSinks : [String] = []
    var selfSinks : Int = 0
    var labels : PlayerLabels
    
    init(name: String, number: Int, tableLable: UILabel, pointsNameLabel: UILabel, bigPointsLabel: UILabel, pointsLabel: UILabel, tinksLabel: UILabel, sinksLabel: UILabel, bounceSinksLabel: UILabel, partnerSinksLabel: UILabel, selfSinksLabel: UILabel) {
        self.playerNumber = number
        self.name = name
        self.points = 0
        self.tinks = []
        self.sinks = []
        self.bounceSinks = []
        self.partnerSinks = []
        self.selfSinks = 0
        self.labels = PlayerLabels(tableLabel: tableLable, pointsNameLabel: pointsNameLabel, bigPointsLabel: bigPointsLabel, pointsLabel: pointsLabel, tinksLabel: tinksLabel, sinksLabel: sinksLabel, bounceSinksLabel: bounceSinksLabel, partnerSinksLabel: partnerSinksLabel, selfSinksLabel: selfSinksLabel)
    }
    
    func getTotalPoints() -> Int {
        var totalPoints = 0
        totalPoints += points
        totalPoints += (tinks.count * 2)
        totalPoints += (bounceSinks.count * 2)
        totalPoints += (sinks.count * 3)
        return totalPoints
    }
    
    func updateNameLabels() {
        self.labels.tableLabel.text = self.name
        self.labels.pointsNameLabel.text = self.name
    }
    
    func updatePointLabels() {
        self.labels.bigPointsLabel.text = String(self.points)
        self.labels.pointsLabel.text = String(self.points)
        self.labels.tinksLabel.text = String(self.tinks.count)
        self.labels.sinksLabel.text = String(self.sinks.count)
        self.labels.bounceSinksLabel.text = String(self.bounceSinks.count)
        self.labels.partnerSinksLabel.text = String(self.partnerSinks.count)
        self.labels.selfSinksLabel.text = String(self.selfSinks)
    }
}

class MainViewController: UIViewController {
    
    // Player name labels
    @IBOutlet weak var playerOneTableLabel: UILabel!
    @IBOutlet weak var playerOnePointsNameLabel: UILabel!
    @IBOutlet weak var playerTwoTableLabel: UILabel!
    @IBOutlet weak var playerTwoPointsNameLabel: UILabel!
    @IBOutlet weak var playerThreeTableLabel: UILabel!
    @IBOutlet weak var playerThreePointsNameLabel: UILabel!
    @IBOutlet weak var playerFourTableLabel: UILabel!
    @IBOutlet weak var playerFourPointsNameLabel: UILabel!
    
    // Points Labels
    @IBOutlet weak var playerOneBigPointsLabel: UILabel!
    @IBOutlet weak var playerOnePointsLabel: UILabel!
    @IBOutlet weak var playerOneTinksLabel: UILabel!
    @IBOutlet weak var playerOneSinksLabel: UILabel!
    @IBOutlet weak var playerOneBounceSinksLabel: UILabel!
    @IBOutlet weak var playerOnePartnerSinksLabel: UILabel!
    @IBOutlet weak var playerOneSelfSinksLabel: UILabel!

    @IBOutlet weak var playerTwoBigPointsLabel: UILabel!
    @IBOutlet weak var playerTwoPointsLabel: UILabel!
    @IBOutlet weak var playerTwoTinksLabel: UILabel!
    @IBOutlet weak var playerTwoSinksLabel: UILabel!
    @IBOutlet weak var playerTwoBounceSinksLabel: UILabel!
    @IBOutlet weak var playerTwoPartnerSinksLabel: UILabel!
    @IBOutlet weak var playerTwoSelfSinksLabel: UILabel!
    
    @IBOutlet weak var playerThreeBigPointsLabel: UILabel!
    @IBOutlet weak var playerThreePointsLabel: UILabel!
    @IBOutlet weak var playerThreeTinksLabel: UILabel!
    @IBOutlet weak var playerThreeSinksLabel: UILabel!
    @IBOutlet weak var playerThreeBounceSinksLabel: UILabel!
    @IBOutlet weak var playerThreePartnerSinksLabel: UILabel!
    @IBOutlet weak var playerThreeSelfSinksLabel: UILabel!
    
    @IBOutlet weak var playerFourBigPointsLabel: UILabel!
    @IBOutlet weak var playerFourPointsLabel: UILabel!
    @IBOutlet weak var playerFourTinksLabel: UILabel!
    @IBOutlet weak var playerFourSinksLabel: UILabel!
    @IBOutlet weak var playerFourBounceSinksLabel: UILabel!
    @IBOutlet weak var playerFourPartnerSinksLabel: UILabel!
    @IBOutlet weak var playerFourSelfSinksLabel: UILabel!
    
    // Plus & Minus Buttons
    @IBOutlet weak var playerOneMinusButton: UIButton!
    @IBOutlet weak var playerOnePlusButton: UIButton!
    @IBOutlet weak var playerTwoMinusButton: UIButton!
    @IBOutlet weak var playerTwoPlusButton: UIButton!
    @IBOutlet weak var playerThreeMinusButton: UIButton!
    @IBOutlet weak var playerThreePlusButton: UIButton!
    @IBOutlet weak var playerFourMinusButton: UIButton!
    @IBOutlet weak var playerFourPlusButton: UIButton!
    
    // Special Points Buttons
    @IBOutlet weak var playerOneSpecialPointsButton: UIButton!
    @IBOutlet weak var playerTwoSpecialPointsButton: UIButton!
    @IBOutlet weak var playerThreeSpecialPointsButton: UIButton!
    @IBOutlet weak var playerFourSpecialPointsButton: UIButton!
    
    // Player Name Buttons
    @IBOutlet weak var playerOneLeftButton: UIButton!
    @IBOutlet weak var playerOneRightButton: UIButton!
    @IBOutlet weak var playerTwoLeftButton: UIButton!
    @IBOutlet weak var playerTwoRightButton: UIButton!
    @IBOutlet weak var playerThreeLeftButton: UIButton!
    @IBOutlet weak var playerThreeRightButton: UIButton!
    @IBOutlet weak var playerFourLeftButton: UIButton!
    @IBOutlet weak var playerFourRightButton: UIButton!
    
    @IBOutlet weak var teamLockSwitch: UISwitch!
    
    // Score Labels
    @IBOutlet weak var teamOneScoreLabel: UILabel!
    @IBOutlet weak var teamTwoScoreLabel: UILabel!
    
    // My variables
    let playerNames : [String] = ["Adam", "Ben", "Jake", "Kyle", "Marcus"]
    var players : [PlayerData] = []
    var myChosenPlayer : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.items?.last?.rightBarButtonItem?.isEnabled = false
        // Do any additional setup after loading the view.
        // Setting up all the player data
        let playerOne = PlayerData(name: playerNames[0], number: 1, tableLable: playerOneTableLabel, pointsNameLabel: playerOnePointsNameLabel, bigPointsLabel: playerOneBigPointsLabel, pointsLabel: playerOnePointsLabel, tinksLabel: playerOneTinksLabel, sinksLabel: playerOneSinksLabel, bounceSinksLabel: playerOneBounceSinksLabel, partnerSinksLabel: playerOnePartnerSinksLabel, selfSinksLabel: playerOneSelfSinksLabel)
        let playerTwo = PlayerData(name: playerNames[1], number: 2, tableLable: playerTwoTableLabel, pointsNameLabel: playerTwoPointsNameLabel, bigPointsLabel: playerTwoBigPointsLabel, pointsLabel: playerTwoPointsLabel, tinksLabel: playerTwoTinksLabel, sinksLabel: playerTwoSinksLabel, bounceSinksLabel: playerTwoBounceSinksLabel, partnerSinksLabel: playerTwoPartnerSinksLabel, selfSinksLabel: playerTwoSelfSinksLabel)
        let playerThree = PlayerData(name: playerNames[2], number: 3, tableLable: playerThreeTableLabel, pointsNameLabel: playerThreePointsNameLabel, bigPointsLabel: playerThreeBigPointsLabel, pointsLabel: playerThreePointsLabel, tinksLabel: playerThreeTinksLabel, sinksLabel: playerThreeSinksLabel, bounceSinksLabel: playerThreeBounceSinksLabel, partnerSinksLabel: playerThreePartnerSinksLabel, selfSinksLabel: playerThreeSelfSinksLabel)
        let playerFour = PlayerData(name: playerNames[3], number: 4, tableLable: playerFourTableLabel, pointsNameLabel: playerFourPointsNameLabel, bigPointsLabel: playerFourBigPointsLabel, pointsLabel: playerFourPointsLabel, tinksLabel: playerFourTinksLabel, sinksLabel: playerFourSinksLabel, bounceSinksLabel: playerFourBounceSinksLabel, partnerSinksLabel: playerFourPartnerSinksLabel, selfSinksLabel: playerFourSelfSinksLabel)
        players.append(playerOne)
        players.append(playerTwo)
        players.append(playerThree)
        players.append(playerFour)
        
        // Setting player name labels
        updatePlayers()
        
        // Setting player point labels
        updatePoints()
        
        // Setting team lock to OFF and points to uneditable
        teamLockSwitch.setOn(false, animated: true)
        enablePlayerNameButtons(inBool: true)
        enableLoggingButtons(inBool: false)
    }
    
    // Player Switching
    @IBAction func playerOneSwitchLeft(_ sender: Any) {
        players[0].name = getPrevPlayer(player: players[0].name)
        updatePlayers()
    }
    @IBAction func playerOneSwitchRight(_ sender: Any) {
        players[0].name = getNextPlayer(player: players[0].name)
        updatePlayers()
    }
    @IBAction func playerTwoSwitchLeft(_ sender: Any) {
        players[1].name = getPrevPlayer(player: players[1].name)
        updatePlayers()
    }
    @IBAction func playerTwoSwitchRight(_ sender: Any) {
        players[1].name = getNextPlayer(player: players[1].name)
        updatePlayers()
    }
    @IBAction func playerThreeSwitchLeft(_ sender: Any) {
        players[2].name = getPrevPlayer(player: players[2].name)
        updatePlayers()
    }
    @IBAction func playerThreeSwitchRight(_ sender: Any) {
        players[2].name = getNextPlayer(player: players[2].name)
        updatePlayers()
    }
    @IBAction func playerFourSwitchLeft(_ sender: Any) {
        players[3].name = getPrevPlayer(player: players[3].name)
        updatePlayers()
    }
    @IBAction func playerFourSwitchRight(_ sender: Any) {
        players[3].name = getNextPlayer(player: players[3].name)
        updatePlayers()
    }
    
    // Point adding & subtracting
    @IBAction func playerOnePointsMinus(_ sender: Any) {
        players[0].points = subtractOne(number: players[0].points)
        updatePoints()
    }
    @IBAction func playerOnePointsPlus(_ sender: Any) {
        players[0].points += 1
        updatePoints()
    }
    @IBAction func playerTwoPointsMinus(_ sender: Any) {
        players[1].points = subtractOne(number: players[1].points)
        updatePoints()
    }
    @IBAction func playerTwoPointsPlus(_ sender: Any) {
        players[1].points += 1
        updatePoints()
    }
    @IBAction func playerThreePointsMinus(_ sender: Any) {
        players[2].points = subtractOne(number: players[2].points)
        updatePoints()
    }
    @IBAction func playerThreePointsPlus(_ sender: Any) {
        players[2].points += 1
        updatePoints()
    }
    @IBAction func playerFourPointsMinus(_ sender: Any) {
        players[3].points = subtractOne(number: players[3].points)
        updatePoints()
    }
    @IBAction func playerFourPointsPlus(_ sender: Any) {
        players[3].points += 1
        updatePoints()
    }
    
    // Special Points Buttons
    @IBAction func playerOneSpecialPointButtonPressed(_ sender: Any) {
        myChosenPlayer = 0
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    @IBAction func playerTwoSpecialPointButtonPressed(_ sender: Any) {
        myChosenPlayer = 1
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    @IBAction func playerThreeSpecialPointButtonPressed(_ sender: Any) {
        myChosenPlayer = 2
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    @IBAction func playerFourSpecialPointButtonPressed(_ sender: Any) {
        myChosenPlayer = 3
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    
    @IBAction func teamLockChanged(_ sender: UISwitch) {
        if(sender.isOn){
            if(getMatchingNames().count != 0){
                sender.setOn(false, animated: true)
            }
            else{
                enablePlayerNameButtons(inBool: false)
                enableLoggingButtons(inBool: true)
            }
        }
        else{
            enablePlayerNameButtons(inBool: true)
            enableLoggingButtons(inBool: false)
        }
    }
    
    
    // My functions
    func updatePlayers(){
        // Check if any of the names match each other. Those will be set to red
        let matching = getMatchingNames()
        for i in (0...3){
            if(matching.contains(i)){
                players[i].labels.pointsNameLabel.textColor = UIColor.red
                players[i].labels.tableLabel.textColor = UIColor.red
            }
            else{
                players[i].labels.pointsNameLabel.textColor = UIColor.black
                players[i].labels.tableLabel.textColor = UIColor.black
            }
        }
        
        for i in (0...3){
            players[i].updateNameLabels()
        }
    }
    
    func updatePoints(){
        teamOneScoreLabel.text = String(getTeamPoints(team: 1))
        teamTwoScoreLabel.text = String(getTeamPoints(team: 2))

        for i in (0...3){
            players[i].updatePointLabels()
        }
        
        // Check if the game can be over
        self.navigationController?.navigationBar.items?.last?.rightBarButtonItem?.isEnabled = checkGameOver()
    }
    
    func getNextPlayer(player: String) -> String {
        let inIndex = playerNames.firstIndex(of: player) ?? 0
        if inIndex == (playerNames.count - 1){
            return playerNames[0]
        }
        else{
            return playerNames[inIndex + 1]
        }
    }
    
    func getPrevPlayer(player: String) -> String {
        let inIndex = playerNames.firstIndex(of: player) ?? 0
        if inIndex == 0{
            return playerNames[playerNames.count - 1]
        }
        else{
            return playerNames[inIndex - 1]
        }
    }
    
    func subtractOne(number: Int) -> Int{
        if(number > 0){
            return number - 1
        }
        else{
            return 0
        }
    }
    
    func getTeamPoints(team: Int) -> Int {
        switch team {
        case 1:
            let totalPoints = players[0].getTotalPoints()
            return totalPoints + players[1].getTotalPoints()
        case 2:
            let totalPoints = players[2].getTotalPoints()
            return totalPoints + players[3].getTotalPoints()
        default:
            return 0
        }
    }
    
    func getMatchingNames() -> [Int] {
        var matching : [Int] = []
        for i in (0...3){
            for j in (0...3){
                if(players[i].name == players[j].name && i != j){
                    matching.append(i)
                    matching.append(j)
                }
            }
        }
        return Array(Set(matching))
    }
    
    func checkGameOver() -> Bool{
        // If neither team has at least 11 the game cannot be saved
        if([getTeamPoints(team: 1), getTeamPoints(team: 2)].max() ?? 0 < 11){
            return false
        }
        // If the winning team isn't up by at least 2 then it cannot be saved
        else if(abs(getTeamPoints(team: 1) - getTeamPoints(team: 2)) < 2){
            return false
        }
        else{
            return true
        }
    }
    
    func enablePlayerNameButtons(inBool: Bool) {
        playerOneLeftButton.isEnabled = inBool
        playerOneRightButton.isEnabled = inBool
        playerTwoLeftButton.isEnabled = inBool
        playerTwoRightButton.isEnabled = inBool
        playerThreeLeftButton.isEnabled = inBool
        playerThreeRightButton.isEnabled = inBool
        playerFourLeftButton.isEnabled = inBool
        playerFourRightButton.isEnabled = inBool
    }
    
    func enableLoggingButtons(inBool: Bool) {
        self.navigationController?.navigationBar.items?.last?.rightBarButtonItem?.isEnabled = (inBool && checkGameOver())
        playerOneMinusButton.isEnabled = inBool
        playerOnePlusButton.isEnabled = inBool
        playerTwoMinusButton.isEnabled = inBool
        playerTwoPlusButton.isEnabled = inBool
        playerThreeMinusButton.isEnabled = inBool
        playerThreePlusButton.isEnabled = inBool
        playerFourMinusButton.isEnabled = inBool
        playerFourPlusButton.isEnabled = inBool
        playerOneSpecialPointsButton.isEnabled = inBool
        playerTwoSpecialPointsButton.isEnabled = inBool
        playerThreeSpecialPointsButton.isEnabled = inBool
        playerFourSpecialPointsButton.isEnabled = inBool
    }
    
    // Other functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toSpecialPointsTable" {
                guard let viewController = segue.destination as? SpecialPointsViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                viewController.players = players
                viewController.chosenPlayer = myChosenPlayer
            }
        }
    }
}

