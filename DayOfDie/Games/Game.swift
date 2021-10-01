//
//  Game.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/4/21.
//

import UIKit

enum GameTrackingType {
    case PointScore
    case PlayerScore
    case GameScore
}

class GameSet {
    private static var allGames : [Game] = []
    
    static func getAllGames() -> [Game] {
        return allGames
    }
    
    static func updateAllGames(gameList: [Game]) {
        for inGame in gameList {
            if !allGames.contains(where: { return $0 == inGame }) {
                // Make references work
                setReferencedTeams(game: inGame)
                setReferencedPlayerForPoints(game: inGame)
                allGames.append(inGame)
            }
        }
    }
    
    static func setReferencedTeams(game: Game) {
        game.homeTeam = TeamSet.getTeam(inTeam: game.homeTeam)
        game.awayTeam = TeamSet.getTeam(inTeam: game.awayTeam)
    }
    
    static func setReferencedPlayerForPoints(game: Game) {
        for point in game.points {
            point.scorer = PlayerSet.getPlayer(inPlayer: point.scorer)
        }
    }
    
    static func getGame(inGame: Game) -> Game {
        for game in allGames {
            if game == inGame {
                return game
            }
        }
        updateAllGames(gameList: [inGame])
        return getGame(inGame: inGame)
    }
    
    static func getTotalPoints() -> [Point] {
        var myTotalPoints : [Point] = []
        for game in getAllGames() {
            myTotalPoints.append(contentsOf: game.points.filter { return $0.scorer == User.player })
        }
        return myTotalPoints
    }
}

class Game : Codable, Equatable {
    var timeStarted : Date?
    var timeEnded : Date?
    
    var uuid : UUID?
    var homeTeam : Team
    var awayTeam : Team
    
    var homeTeamScore : Int
    var awayTeamScore : Int
    var confirmed : Bool
    
    var points : [Point]
    
//    init(teamOne: Team, teamTwo: Team, points: [Point]) {
//        self.homeTeam = teamOne
//        self.awayTeam = teamTwo
//        self.homeTeamScore = 0
//        self.awayTeamScore = 0
//        self.confirmed = false
//        self.points = points
//    }
    
    init(playerOne: Player, playerTwo: Player, playerThree: Player, playerFour: Player, points: [Point]){
        self.homeTeam = Team(teamCaptain: playerOne, teammate: playerTwo)
        self.awayTeam = Team(teamCaptain: playerThree, teammate: playerFour)
        self.homeTeamScore = 0
        self.awayTeamScore = 0
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
        self.awayTeamScore = try container.decode(Int.self, forKey: .awayTeamScore)
        self.confirmed = try container.decode(Bool.self, forKey: .confirmed)
        self.points = try container.decode([Point].self, forKey: .points)
    }
    
    static func getRecord(team: Team , games: [Game]) -> (Int, Int) {
        var wins  = 0
        var losses = 0
        
        for game in games {
            if game.homeTeam == team {
                if game.homeTeamScore > game.awayTeamScore {
                    wins += 1
                }
                else {
                    losses += 1
                }
            }
            else if game.awayTeam == team {
                if game.homeTeamScore > game.awayTeamScore {
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
    
    func didPlayerWin(player: Player) -> Bool {
        if isOnHomeTeam(player: player) {
            return homeTeamScore > awayTeamScore
        } else {
            return awayTeamScore > homeTeamScore
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case timeStarted = "time_started"
        case timeEnded = "time_ended"
        case uuid
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        
        case homeTeamScore = "home_team_score"
        case awayTeamScore = "away_team_score"
        case confirmed
        case points
    }
    
    static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func getGameTrackingType() -> GameTrackingType {
        if points.isEmpty {
            return GameTrackingType.GameScore
        } else if points.contains(where: { $0.typeOfPoint == PointTypes.UNTRACKED }) {
            return GameTrackingType.PlayerScore
        } else {
            return GameTrackingType.PointScore
        }
    }
}
