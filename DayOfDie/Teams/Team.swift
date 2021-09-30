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

class TeamSet {
    private static var allTeams : [Team] = []
    static var allTeammates : [Player] { get { return allTeams.map { $0.getOtherUser()}}}
    static var acceptedTeams : [Team] { get { return allTeams.filter { return $0.status == .ACCEPTED}}}
    static var acceptedTeammates : [Player] { get { return acceptedTeams.map { $0.getOtherUser()}}}
    static var pendingTeams : [Team] { get { return allTeams.filter { return $0.status == .PENDING && $0.loggedInUserIsTeamCaptain()}}}
    static var pendingTeammates : [Player] { get { return pendingTeams.map { $0.getOtherUser()}}}
    static var waitingTeams : [Team] { get { return allTeams.filter { return $0.status == .PENDING &&  !$0.loggedInUserIsTeamCaptain()}}}
    static var waitingTeammates : [Player] { get { return waitingTeams.map { $0.getOtherUser()}}}
    static var nothingTeams : [Team] { get { return allTeams.filter { return $0.status == .NOTHING}}}
    static var nothingTeammates : [Player] { get { return nothingTeams.map { $0.getOtherUser()}}}
    static var blockedTeams : [Team] { get { return allTeams.filter { return $0.status == .BLOCKED}}}
    static var blockedTeammates : [Player] { get { return blockedTeams.map { $0.getOtherUser()}}}
    
    static func getAllTeams() -> [Team] {
        return allTeams
    }
    
    static func updateAllTeams(teamList: [Team]) {
        for inTeam in teamList {
            let index = allTeams.firstIndex(of: inTeam)
            if index == nil {
                setReferencedPlayers(team: inTeam)
                allTeams.append(inTeam)
            } else {
                allTeams[index!].wins = inTeam.wins
                allTeams[index!].losses = inTeam.losses
                allTeams[index!].status = inTeam.status
                allTeams[index!].teamName = inTeam.teamName
            }
        }
    }
    
    static func getTeamStatus(player: Player) -> TeamStatuses {
        if acceptedTeammates.contains(player) { return .ACCEPTED }
        else if pendingTeammates.contains(player) { return .PENDING }
        else if waitingTeammates.contains(player) { return .WAITING }
        else if blockedTeammates.contains(player) { return .BLOCKED }
        else { return .NOTHING }
    }
    
    static func setReferencedPlayers(team: Team) {
        team.teamCaptain = PlayerSet.getPlayer(inPlayer: team.teamCaptain)
        team.teammate = PlayerSet.getPlayer(inPlayer: team.teammate)
    }
    
    static func getTeam(inTeam: Team) -> Team {
        for team in allTeams {
            if team == inTeam {
                return team
            }
        }
        updateAllTeams(teamList: [inTeam])
        return getTeam(inTeam: inTeam)
    }
}

class Team : Codable, Equatable, Searchable {
    var teamCaptain : Player
    var teammate : Player
    var teamName : String?
    var uuid : UUID?
    var status : TeamStatuses?
    var wins : Int
    var losses : Int
    
    init(teamCaptain: Player, teammate: Player) {
        self.teamCaptain = teamCaptain
        self.teammate = teammate
        wins = 0
        losses = 0
    }
    
    func getOtherUser() -> Player {
        if(User.player == teamCaptain){
            return teammate
        }
        else{
            return teamCaptain
        }
    }
    
    func getTeamName() -> String {
        if teamName == nil { return "\(teamCaptain.username) & \(teammate.username)" }
        else { return teamName! }
    }
    
    func loggedInUserIsTeamCaptain() -> Bool {
        return User.player == teamCaptain
    }
    
    func isOnTeam(player: Player) -> Bool {
        return player == teamCaptain || player == teammate
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        if(lhs.teamCaptain == rhs.teamCaptain && lhs.teammate == rhs.teammate){
            return true
        }
        return lhs.teamCaptain == rhs.teammate && lhs.teammate == rhs.teamCaptain
    }
    
    enum CodingKeys : String, CodingKey {
        case teamCaptain = "team_captain"
        case teammate
        case teamName = "team_name"
        case uuid
        case wins
        case losses
        case status
    }
    
    func getSearchString() -> String {
        return getTeamName()
    }
}
