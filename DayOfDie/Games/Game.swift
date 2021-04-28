//
//  Game.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/4/21.
//

import UIKit


enum GameTypes : String, Codable{
    case PICKUP = "pu"
    case MARATHON = "ma"
    case TOURNAMENT = "tm"
}

class Game : Codable {
    var timeStarted : String?
    var timeEnded : String?
    
    var uuid : UUID?
    var type : GameTypes
    var teamOne : Friend
    var teamTwo : Friend
    
    var teamOneScore : Int
    var teamTwoScore : Int
    var confirmed : Bool
    
    var points : [Point]
    
    init(teamOne: Friend, teamTwo: Friend, points: [Point]) {
        self.type = GameTypes.PICKUP
        self.teamOne = teamOne
        self.teamTwo = teamTwo
        self.teamOneScore = 0
        self.teamTwoScore = 0
        self.confirmed = false
        self.points = points
    }
    
    init(playerOne: BasicUser, playerTwo: BasicUser, playerThree: BasicUser, playerFour: BasicUser, points: [Point]){
        self.type = GameTypes.PICKUP
        self.teamOne = Friend(teamCaptain: playerOne, teammate: playerTwo)
        self.teamTwo = Friend(teamCaptain: playerThree, teammate: playerFour)
        self.teamOneScore = 0
        self.teamTwoScore = 0
        self.confirmed = false
        self.points = points
    }
    
    func setStartTimeNow() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        self.timeStarted = df.string(from: Date())
    }
    
    func setEndTimeNow() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        self.timeEnded = df.string(from: Date())
    }
    
    enum CodingKeys : String, CodingKey {
        case timeStarted = "time_started"
        case timeEnded = "time_ended"
        case uuid
        case type
        case teamOne = "team_one"
        case teamTwo = "team_two"
        
        case teamOneScore = "team_one_score"
        case teamTwoScore = "team_two_score"
        case confirmed
        case points
    }
}
