//
//  Game.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/4/21.
//

import UIKit

class Game : Decodable, Encodable, Equatable {
    static var allGames : [Game] = []
    var timeStarted : Date?
    var timeEnded : Date?
    
    var uuid : UUID?
    var teamOne : Team
    var teamTwo : Team
    
    var teamOneScore : Int
    var teamTwoScore : Int
    var confirmed : Bool
    
    var points : [Point]
    
    init(teamOne: Team, teamTwo: Team, points: [Point]) {
        self.teamOne = teamOne
        self.teamTwo = teamTwo
        self.teamOneScore = 0
        self.teamTwoScore = 0
        self.confirmed = false
        self.points = points
    }
    
    init(playerOne: Player, playerTwo: Player, playerThree: Player, playerFour: Player, points: [Point]){
        self.teamOne = Team(teamCaptain: playerOne, teammate: playerTwo)
        self.teamTwo = Team(teamCaptain: playerThree, teammate: playerFour)
        self.teamOneScore = 0
        self.teamTwoScore = 0
        self.confirmed = false
        self.points = points
    }
    
    required init(from decoder: Decoder) throws {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        let timeStartedString = try container.decode(String.self, forKey: .timeStarted)
        let timeEndedString = try container.decode(String.self, forKey: .timeStarted)
        print("timeStartedString \(timeStartedString)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.timeStarted = dateFormatter.date(from: timeStartedString)
        self.timeEnded = dateFormatter.date(from: timeEndedString)
        
        self.uuid = try container.decode(UUID.self, forKey: .uuid)
        self.teamOne = try container.decode(Team.self, forKey: .teamOne)
        self.teamTwo = try container.decode(Team.self, forKey: .teamTwo)
        self.teamOneScore = try container.decode(Int.self, forKey: .teamOneScore)
        self.teamTwoScore = try container.decode(Int.self, forKey: .teamTwoScore)
        self.confirmed = try container.decode(Bool.self, forKey: .confirmed)
        self.points = try container.decode([Point].self, forKey: .points)
    }
    
    enum DecodingKeys : String, CodingKey {
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
    
    enum EncodingKeys : String, CodingKey {
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
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
