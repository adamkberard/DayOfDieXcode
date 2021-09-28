//
//  Game.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/4/21.
//

import UIKit


class Game : Codable, Equatable {
    static var allGames : [Game] = [] {
        didSet {
            referenceGames()
        }
    }
    var timeStarted : Date?
    var timeEnded : Date?
    
    var uuid : UUID?
    var homeTeam : Team
    var awayTeam : Team
    
    var homeTeamScore : Int
    var teamTwoScore : Int
    var confirmed : Bool
    
    var points : [Point]
    
    static func referenceGames() {
        for game in allGames {
            game.setReferencedTeams()
            game.setReferencedPlayerForPoints()
        }
    }
    
    func setReferencedTeams() {
        self.homeTeam = Team.findOrCreateTeam(inTeam: self.homeTeam)
        self.awayTeam = Team.findOrCreateTeam(inTeam: self.awayTeam)
    }
    
    func setReferencedPlayerForPoints() {
        for point in points {
            point.scorer = Player.getPlayer(inPlayer: point.scorer)
        }
    }
    
    init(teamOne: Team, teamTwo: Team, points: [Point]) {
        self.homeTeam = teamOne
        self.awayTeam = teamTwo
        self.homeTeamScore = 0
        self.teamTwoScore = 0
        self.confirmed = false
        self.points = points
    }
    
    init(playerOne: Player, playerTwo: Player, playerThree: Player, playerFour: Player, points: [Point]){
        self.homeTeam = Team(teamCaptain: playerOne, teammate: playerTwo)
        self.awayTeam = Team(teamCaptain: playerThree, teammate: playerFour)
        self.homeTeamScore = 0
        self.teamTwoScore = 0
        self.confirmed = false
        self.points = points
    }
    
    required init(from decoder: Decoder) throws {
        // Get our container for this subclass' coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let timeStartedString = try container.decode(String.self, forKey: .timeStarted)
        let timeEndedString = try container.decode(String.self, forKey: .timeStarted)
        let dateFormatter = ISO8601DateFormatter()
        self.timeStarted = dateFormatter.date(from: timeStartedString)
        self.timeEnded = dateFormatter.date(from: timeEndedString)
        self.uuid = try container.decode(UUID.self, forKey: .uuid)
        self.homeTeam = try container.decode(Team.self, forKey: .homeTeam)
        self.awayTeam = try container.decode(Team.self, forKey: .awayTeam)
        self.homeTeamScore = try container.decode(Int.self, forKey: .homeTeamScore)
        self.teamTwoScore = try container.decode(Int.self, forKey: .teamTwoScore)
        self.confirmed = try container.decode(Bool.self, forKey: .confirmed)
        self.points = try container.decode([Point].self, forKey: .points)
    }
    
    static func getRecord(team: Team , games: [Game]) -> (Int, Int) {
        var wins  = 0
        var losses = 0
        
        for game in games {
            if game.homeTeam == team {
                if game.homeTeamScore > game.teamTwoScore {
                    wins += 1
                }
                else {
                    losses += 1
                }
            }
            else if game.awayTeam == team {
                if game.homeTeamScore > game.teamTwoScore {
                    losses += 1
                }
                else {
                    wins += 1
                }
            }
        }
        return (wins, losses)
    }
    
    func isOnHomeTeam(player: Player) -> Bool {
        return homeTeam.isOnTeam(player: player)
    }
    
    enum CodingKeys : String, CodingKey {
        case timeStarted = "time_started"
        case timeEnded = "time_ended"
        case uuid
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        
        case homeTeamScore = "home_team_score"
        case teamTwoScore = "away_team_score"
        case confirmed
        case points
    }
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
