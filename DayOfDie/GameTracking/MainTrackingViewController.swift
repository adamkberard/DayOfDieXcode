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
    @IBOutlet weak var scoreboard: PlayersTableScoreView!
    @IBOutlet weak var saveButton: UIButton!
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var playerOne : BasicUser = CurrentUser.basicUser
    var playerTwo : BasicUser = CurrentUser.basicUser
    var playerThree : BasicUser = CurrentUser.basicUser
    var playerFour : BasicUser = CurrentUser.basicUser
    
    var currentlyPickedPoints : Int = 0
    
    var teamOneScore : Int = 0 {
        didSet {
            scoreboard.teamOneScore = teamOneScore
            checkGameOver()
        }
    }
    var teamTwoScore : Int = 0 {
        didSet {
            scoreboard.teamTwoScore = teamTwoScore
            checkGameOver()
        }
    }
    
    var timeStarted : Date = Date()
    var returnedGame : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        
        
        // Create the game
        for playerScoreTracker in playerScoreTrackers! {
            playerScoreTracker.mainTrackingViewController = self
        }
        scoreboard.playerOne = playerOne
        scoreboard.playerTwo = playerTwo
        scoreboard.playerThree = playerThree
        scoreboard.playerFour = playerFour
        
        (playerScoreTrackers!)[0].player = playerOne
        (playerScoreTrackers!)[0].playerNumber = 1
        
        (playerScoreTrackers!)[1].player = playerTwo
        (playerScoreTrackers!)[1].playerNumber = 2
        
        (playerScoreTrackers!)[2].player = playerThree
        (playerScoreTrackers!)[2].playerNumber = 3
        
        (playerScoreTrackers!)[3].player = playerFour
        (playerScoreTrackers!)[3].playerNumber = 4
    }
    
    // This is the function that everything calls when they update points
    func pointsDidChange() {
        // Just gotta update the player score labels and the team score labels
        teamOneScore = playerScoreTrackers![0].numPoints + playerScoreTrackers![1].numPoints
        teamTwoScore = playerScoreTrackers![2].numPoints + playerScoreTrackers![3].numPoints
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkGameOver()
    }
    
    private func checkGameOver(){
        let playToScore : Int = 11
        let winBy : Int = 2
        
        if abs(scoreboard.teamOneScore - scoreboard.teamTwoScore) < winBy {
            saveButton.isEnabled = false
        }
        else if max(scoreboard.teamOneScore, scoreboard.teamTwoScore) < playToScore {
            saveButton.isEnabled = false
        }
        else{
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func saveGameButtonPressed(_ sender: Any) {
        // Now it sends the data to me
        // Prepare json data
        
        var allPoints : [[String : String]] = []
        for playerScoreTracker in playerScoreTrackers!{
            for point in playerScoreTracker.points{
                let tempDict : [String : String] = ["type": point.typeOfPoint.rawValue, "scorer" : point.scorer.uuid]
                allPoints.append(tempDict)
            }
        }
        
        var parameters : Dictionary<String, Any> = [
            "playerOne": playerOne.uuid,
            "playerTwo": playerTwo.uuid,
            "playerThree": playerThree.uuid,
            "playerFour": playerFour.uuid,
            "team_one_score": scoreboard.teamOneScore,
            "team_two_score": scoreboard.teamTwoScore,
            "confirmed": false,
            "type": "pu",
            "points": allPoints
        ]

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        parameters["time_started"] = df.string(from: timeStarted)
        parameters["time_ended"] = df.string(from: Date())
        
        AF.request("\(URLInfo.baseUrl)/games/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: CurrentUser.getHeaders()).responseDecodable(of: Game.self) {response in
            // Turn off activity indicator
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            switch response.result {
                case .success:
                    self.returnedGame = response.value!
                    CurrentUser.games.append(self.returnedGame!)
                    if self.scoreboard.teamOneScore > self.scoreboard.teamTwoScore{
                        Friend.findOrCreateFriend(teamCaptain: self.playerOne, teammate: self.playerTwo).wins += 1
                        Friend.findOrCreateFriend(teamCaptain: self.playerThree, teammate: self.playerFour).losses += 1
                    }
                    else{
                        Friend.findOrCreateFriend(teamCaptain: self.playerOne, teammate: self.playerTwo).losses += 1
                        Friend.findOrCreateFriend(teamCaptain: self.playerThree, teammate: self.playerFour).wins += 1
                    }
                    self.performSegue(withIdentifier: "toGameAfterSave", sender: self)
                case .failure:
                    print("Error: \(String(decoding: response.data!, as: UTF8.self))")
            }
        }
        
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
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
            else if identifier == "toGameAfterSave" {
                guard let viewController = segue.destination as? GameTableViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                viewController.needToGoToLastGame = true
            }
        }
    }
}
