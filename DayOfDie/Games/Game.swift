//
//  Game.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/4/21.
//

import UIKit

class Game : Codable {
    var timeStarted : String?
    var timeEnded : String?
    
    var uuid : UUID?
    var teamOne : Friend
    var teamTwo : Friend
    
    var teamOneScore : Int
    var teamTwoScore : Int
    var confirmed : Bool
    
    var points : [Point]
    
    init(teamOne: Friend, teamTwo: Friend, points: [Point]) {
        self.teamOne = teamOne
        self.teamTwo = teamTwo
        self.teamOneScore = 0
        self.teamTwoScore = 0
        self.confirmed = false
        self.points = points
    }
    
    init(playerOne: BasicUser, playerTwo: BasicUser, playerThree: BasicUser, playerFour: BasicUser, points: [Point]){
        self.teamOne = Friend(teamCaptain: playerOne, teammate: playerTwo)
        self.teamTwo = Friend(teamCaptain: playerThree, teammate: playerFour)
        self.teamOneScore = 0
        self.teamTwoScore = 0
        self.confirmed = false
        self.points = points
    }
    
    enum CodingKeys : String, CodingKey {
        case timeStarted = "time_started"
        case timeEnded = "time_ended"
        case uuid
        case teamOne = "team_one"
        case teamTwo = "team_two"
        
        case teamOneScore = "team_one_score"
        case teamTwoScore = "team_two_score"
        case confirmed
        case points
    }
}
