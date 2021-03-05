//
//  ViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/2/21.
//

import UIKit
import Alamofire

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
    // Eventually need to request these names
    var game : Game = Game()
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.items?.last?.rightBarButtonItem?.isEnabled = false
        // Do any additional setup after loading the view.
        game.createPlayers()
        game.saveButton = self.navigationController?.navigationBar.items?.last?.rightBarButtonItem!
        setPlayerLabels(game: game)
        
        // Setup labels with PlayerLabels models
        setPlayerLabels(game: game)
        
        // Setting player name labels
        setPlayerLabels(game: game)
        for i in 0...3{
            game.players[i].labels.updateNameLabels()
            game.players[i].labels.updatePointLabels()
        }
        
        // Setting team lock to OFF and points to uneditable
        teamLockSwitch.setOn(false, animated: true)
        enablePlayerNameButtons(inBool: true)
        enableLoggingButtons(inBool: false)
        
        // Activity Indicator stuff
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        game.getChosenPlayer().labels.updatePointLabels()
        game.updateTeamScoreLabels()
    }
    
    // Player Switching
    @IBAction func playerOneSwitchLeft(_ sender: Any) {
        game.getPlayerOne().setPrevName()
    }
    @IBAction func playerOneSwitchRight(_ sender: Any) {
        game.getPlayerOne().setNextName()
    }
    @IBAction func playerTwoSwitchLeft(_ sender: Any) {
        game.getPlayerTwo().setPrevName()
    }
    @IBAction func playerTwoSwitchRight(_ sender: Any) {
        game.getPlayerTwo().setNextName()
    }
    @IBAction func playerThreeSwitchLeft(_ sender: Any) {
        game.getPlayerThree().setPrevName()
    }
    @IBAction func playerThreeSwitchRight(_ sender: Any) {
        game.getPlayerThree().setNextName()
    }
    @IBAction func playerFourSwitchLeft(_ sender: Any) {
        game.getPlayerFour().setPrevName()
    }
    @IBAction func playerFourSwitchRight(_ sender: Any) {
        game.getPlayerFour().setNextName()
    }
    
    // Point adding & subtracting
    @IBAction func playerOnePointsMinus(_ sender: Any) {
        game.getPlayerOne().subtractPoint()
    }
    @IBAction func playerOnePointsPlus(_ sender: Any) {
        game.getPlayerOne().addPoint()
    }
    @IBAction func playerTwoPointsMinus(_ sender: Any) {
        game.getPlayerTwo().subtractPoint()
    }
    @IBAction func playerTwoPointsPlus(_ sender: Any) {
        game.getPlayerTwo().addPoint()
    }
    @IBAction func playerThreePointsMinus(_ sender: Any) {
        game.getPlayerThree().subtractPoint()
    }
    @IBAction func playerThreePointsPlus(_ sender: Any) {
        game.getPlayerThree().addPoint()
    }
    @IBAction func playerFourPointsMinus(_ sender: Any) {
        game.getPlayerFour().subtractPoint()
    }
    @IBAction func playerFourPointsPlus(_ sender: Any) {
        game.getPlayerFour().addPoint()
    }
    
    // Special Points Buttons
    @IBAction func playerOneSpecialPointButtonPressed(_ sender: Any) {
        game.chosenPlayer = 0
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    @IBAction func playerTwoSpecialPointButtonPressed(_ sender: Any) {
        game.chosenPlayer = 1
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    @IBAction func playerThreeSpecialPointButtonPressed(_ sender: Any) {
        game.chosenPlayer = 2
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    @IBAction func playerFourSpecialPointButtonPressed(_ sender: Any) {
        game.chosenPlayer = 3
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    
    @IBAction func teamLockChanged(_ sender: UISwitch) {
        if(sender.isOn){
            if(game.namesAreValid()){
                enablePlayerNameButtons(inBool: false)
                enableLoggingButtons(inBool: true)
            }
            else{
                sender.setOn(false, animated: true)
            }
        }
        else{
            let refreshAlert = UIAlertController(title: "ARE YOU SURE?!", message: "Are you sure you want to change the teams?", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.enablePlayerNameButtons(inBool: true)
                self.enableLoggingButtons(inBool: false)
            }))

            refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel))

            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveGameButtonPressed(_ sender: Any) {
        // Now it sends the data to me
        // Prepare json data
        let gameDict : [String: Any] = game.toDict()
        
        let parameters : [String: Any] = [
            "game": gameDict
        ]
        
        AF.request("http://127.0.0.1:8000/game/", method: .post, parameters: parameters, encoding:JSONEncoding.default).responseJSON { response in
            // Turn off activity indicator
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            if let statusCode = response.response?.statusCode {
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
                if((200...299).contains(statusCode)){
                    // Eventually I will need to wipe the screen clear to let them know it's been saved
                    // Maybe even send them to the games screen. Will do that rn
                }
                else{
                    print("IDK WHAT HAPPENED \(response.response!.statusCode)")
                    debugPrint(response)
                }
            }
            else{
                print("no connection")
            }
        }
        
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func setPlayerLabels(game: Game) {
        // Player name labels
        game.getPlayerOne().labels.tableLabel = playerOneTableLabel
        game.getPlayerOne().labels.pointsNameLabel = playerOnePointsNameLabel
        game.getPlayerTwo().labels.tableLabel = playerTwoTableLabel
        game.getPlayerTwo().labels.pointsNameLabel = playerTwoPointsNameLabel
        game.getPlayerThree().labels.tableLabel = playerThreeTableLabel
        game.getPlayerThree().labels.pointsNameLabel = playerThreePointsNameLabel
        game.getPlayerFour().labels.tableLabel = playerFourTableLabel
        game.getPlayerFour().labels.pointsNameLabel = playerFourPointsNameLabel
        
        // Points Labels
        game.getPlayerOne().labels.bigPointsLabel = playerOneBigPointsLabel
        game.getPlayerOne().labels.pointsLabel = playerOnePointsLabel
        game.getPlayerOne().labels.tinksLabel = playerOneTinksLabel
        game.getPlayerOne().labels.sinksLabel = playerOneSinksLabel
        game.getPlayerOne().labels.bounceSinksLabel = playerOneBounceSinksLabel
        game.getPlayerOne().labels.partnerSinksLabel = playerOnePartnerSinksLabel
        game.getPlayerOne().labels.selfSinksLabel = playerOneSelfSinksLabel

        game.getPlayerTwo().labels.bigPointsLabel = playerTwoBigPointsLabel
        game.getPlayerTwo().labels.pointsLabel = playerTwoPointsLabel
        game.getPlayerTwo().labels.tinksLabel = playerTwoTinksLabel
        game.getPlayerTwo().labels.sinksLabel = playerTwoSinksLabel
        game.getPlayerTwo().labels.bounceSinksLabel = playerTwoBounceSinksLabel
        game.getPlayerTwo().labels.partnerSinksLabel = playerTwoPartnerSinksLabel
        game.getPlayerTwo().labels.selfSinksLabel = playerTwoSelfSinksLabel
        
        game.getPlayerThree().labels.bigPointsLabel = playerThreeBigPointsLabel
        game.getPlayerThree().labels.pointsLabel = playerThreePointsLabel
        game.getPlayerThree().labels.tinksLabel = playerThreeTinksLabel
        game.getPlayerThree().labels.sinksLabel = playerThreeSinksLabel
        game.getPlayerThree().labels.bounceSinksLabel = playerThreeBounceSinksLabel
        game.getPlayerThree().labels.partnerSinksLabel = playerThreePartnerSinksLabel
        game.getPlayerThree().labels.selfSinksLabel = playerThreeSelfSinksLabel
        
        game.getPlayerFour().labels.bigPointsLabel = playerFourBigPointsLabel
        game.getPlayerFour().labels.pointsLabel = playerFourPointsLabel
        game.getPlayerFour().labels.tinksLabel = playerFourTinksLabel
        game.getPlayerFour().labels.sinksLabel = playerFourSinksLabel
        game.getPlayerFour().labels.bounceSinksLabel = playerFourBounceSinksLabel
        game.getPlayerFour().labels.partnerSinksLabel = playerFourPartnerSinksLabel
        game.getPlayerFour().labels.selfSinksLabel = playerFourSelfSinksLabel
        
        // Score Labels
        game.teamScoreLabels = []
        game.teamScoreLabels.append(teamOneScoreLabel)
        game.teamScoreLabels.append(teamTwoScoreLabel)
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
                viewController.PrevViewController = self
                viewController.chosenPlayerNumber = game.chosenPlayer
                viewController.player = game.getChosenPlayer()
            }
        }
    }
}

