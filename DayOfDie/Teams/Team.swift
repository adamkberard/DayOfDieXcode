//
//  Game.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/4/21.
//

import UIKit

enum TeamStatuses : String, Codable{
    case BLOCKED = "bl"
    case PENDING = "pd"
    case ACCEPTED = "ac"
    case NOTHING = "nt"
    case WAITING = "wt"
}

class Team : Codable, Equatable {
    static var allTeams : [Team] = [] {
        didSet{
            self.parseTeams()
        }
    }
    static var approvedTeams : [Team] = []
    static var approvedTeammates : [Player] = []
    static var pendingTeams : [Team] = []
    static var pendingTeammates : [Player] = []
    static var waitingTeams : [Team] = []
    static var waitingTeammates : [Player] = []
    static var nothingTeams : [Team] = []
    static var nothingTeammates : [Player] = []
    static var blockedTeams : [Team] = []
    static var blockedTeammates : [Player] = []
    
    static func getTeamStatus(player: Player) -> TeamStatuses {
        if approvedTeammates.contains(player) {
            return .ACCEPTED
        }
        else if pendingTeammates.contains(player) {
            return .PENDING
        }
        else if waitingTeammates.contains(player) {
            return .WAITING
        }
        else if blockedTeammates.contains(player) {
            return .BLOCKED
        }
        else {
            return .NOTHING
        }
    }
    
    var teamCaptain : Player
    var teammate : Player
    var uuid : UUID?
    var status : TeamStatuses?
    var wins : Int
    var losses : Int
    
    var teamName : String {
        get {
            return "\(teamCaptain.username) + \(teammate.username)"
        }
    }
    
    init(teamCaptain: Player, teammate: Player) {
        self.teamCaptain = teamCaptain
        self.teammate = teammate
        wins = 0
        losses = 0
    }
    
    func getOtherUser() -> Player {
        if(User.player == teamCaptain){
            return Player.getPlayer(inPlayer: teammate)!
        }
        else{
            return Player.getPlayer(inPlayer: teamCaptain)!
        }
    }
    
    func loggedInUserIsTeamCaptain() -> Bool {
        return User.player == teamCaptain
    }
    
    static func findOrCreateTeam(teamCaptain: Player, teammate: Player) -> Team {
        let tempTeam = Team(teamCaptain: teamCaptain, teammate: teammate)
        for team in allTeams{
            if team == tempTeam{
                return team
            }
        }
        return tempTeam
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        if(lhs.teamCaptain == rhs.teamCaptain && lhs.teammate == rhs.teammate){
            return true
        }
        return lhs.teamCaptain == rhs.teammate && lhs.teammate == rhs.teamCaptain
    }
    
    static func parseTeams() {
        self.pendingTeams = []
        self.pendingTeammates = []
        self.waitingTeams = []
        self.waitingTeammates = []
        self.nothingTeams = []
        self.nothingTeammates = []
        self.approvedTeams = []
        self.approvedTeammates = []
        self.blockedTeams = []
        self.blockedTeammates = []
        
        for team in self.allTeams{
            switch team.status {
            case .ACCEPTED:
                approvedTeams.append(team)
                approvedTeammates.append(team.getOtherUser())
            case .PENDING:
                if team.loggedInUserIsTeamCaptain(){
                    waitingTeams.append(team)
                    waitingTeammates.append(team.getOtherUser())
                }
                else{
                    pendingTeams.append(team)
                    pendingTeammates.append(team.getOtherUser())
                }
            case .NOTHING:
                nothingTeams.append(team)
                nothingTeammates.append(team.getOtherUser())
            case .BLOCKED:
                blockedTeams.append(team)
                blockedTeammates.append(team.getOtherUser())
            default:
                print("Team has invalid status.")
            }
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case teamCaptain = "team_captain"
        case teammate
        case uuid
        case wins
        case losses
        case status
    }
}
