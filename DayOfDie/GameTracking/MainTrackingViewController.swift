//
//  ViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/2/21.
//

import UIKit
import Alamofire

class MainTrackingViewController: UIViewController {
    
    @IBOutlet var playerScoreTrackers : [PlayerScorePicker]?
    @IBOutlet weak var playerScoreTable: PlayersTableScoreView!
    
    var game : Game?
    var playerNames : [String] = []
    var currentlyPickedPoints : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.items?.last?.rightBarButtonItem?.isEnabled = false
        
        // Create the game
        let playerOne = BasicUser.getBasicUser(username: playerNames[0])
        let playerTwo = BasicUser.getBasicUser(username: playerNames[1])
        let playerThree = BasicUser.getBasicUser(username: playerNames[2])
        let playerFour = BasicUser.getBasicUser(username: playerNames[3])
        let teamOne = Friend(teamCaptain: playerOne, teammate: playerTwo)
        let teamTwo = Friend(teamCaptain: playerThree, teammate: playerFour)
        game = Game(teamOne: teamOne, teamTwo: teamTwo)
        
        for playerScoreTracker in playerScoreTrackers! {
            playerScoreTracker.mainTrackingViewController = self
        }
        
        (playerScoreTrackers!)[0].player = playerOne
        (playerScoreTrackers!)[0].teammate = playerTwo
        (playerScoreTrackers!)[0].opponentOne = playerThree
        (playerScoreTrackers!)[0].opponentTwo = playerFour
        (playerScoreTrackers!)[0].playerNumber = 1
        
        (playerScoreTrackers!)[1].player = playerTwo
        (playerScoreTrackers!)[1].teammate = playerOne
        (playerScoreTrackers!)[1].opponentOne = playerThree
        (playerScoreTrackers!)[1].opponentTwo = playerFour
        (playerScoreTrackers!)[1].playerNumber = 2
        
        (playerScoreTrackers!)[2].player = playerThree
        (playerScoreTrackers!)[2].teammate = playerFour
        (playerScoreTrackers!)[2].opponentOne = playerOne
        (playerScoreTrackers!)[2].opponentTwo = playerTwo
        (playerScoreTrackers!)[2].playerNumber = 3
        
        (playerScoreTrackers!)[3].player = playerFour
        (playerScoreTrackers!)[3].teammate = playerThree
        (playerScoreTrackers!)[3].opponentOne = playerOne
        (playerScoreTrackers!)[3].opponentTwo = playerTwo
        (playerScoreTrackers!)[3].playerNumber = 4
        
        playerScoreTable.setPlayers(playerOne: playerOne, playerTwo: playerTwo, playerThree: playerThree, playerFour: playerFour)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func saveGameButtonPressed(_ sender: Any) {
        // Now it sends the data to me
        // Prepare json data
        /*let gameDict : [String: Any] = game.toDict()
        
        let parameters : [String: Any] = [
            "game": gameDict
        ]
        let url = "\(URLInfo.baseUrl)/game/"
        AF.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default).responseJSON { response in
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
        view.isUserInteractionEnabled = false*/
    }
    
    //MARK: Segue Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toPlayerPoints" {
                guard let viewController = segue.destination as? PlayerPointsTableViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                viewController.points = (playerScoreTrackers!)[currentlyPickedPoints].points
                viewController.mainTrackingViewController = self
            }
        }
    }
}
