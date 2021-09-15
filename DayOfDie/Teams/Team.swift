//
//  Game.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/4/21.
//

import UIKit

enum FriendStatuses : String, Codable{
    case BLOCKED = "bl"
    case PENDING = "pd"
    case ACCEPTED = "ac"
    case NOTHING = "nt"
    case WAITING = "wt"
}

class Team : Codable, Equatable {
    static var allFriends : [Team] = [] {
        didSet{
            self.parseFriends()
        }
    }
    static var approvedFriends : [Team] = []
    static var approvedFriendsUsers : [Player] = []
    static var pendingFriends : [Team] = []
    static var pendingFriendsUsers : [Player] = []
    static var waitingFriends : [Team] = []
    static var waitingFriendsUsers : [Player] = []
    static var nothingFriends : [Team] = []
    static var nothingFriendsUsers : [Player] = []
    static var blockedFriends : [Team] = []
    static var blockedFriendsUsers : [Player] = []
    
    static func getFriendStatus(player: Player) -> FriendStatuses {
        if approvedFriendsUsers.contains(player) {
            return .ACCEPTED
        }
        else if pendingFriendsUsers.contains(player) {
            return .PENDING
        }
        else if waitingFriendsUsers.contains(player) {
            return .WAITING
        }
        else if blockedFriendsUsers.contains(player) {
            return .BLOCKED
        }
        else {
            return .NOTHING
        }
    }
    
    var teamCaptain : Player
    var teammate : Player
    var uuid : UUID?
    var status : FriendStatuses?
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
            return teammate
        }
        else{
            return teamCaptain
        }
    }
    
    func loggedInUserIsTeamCaptain() -> Bool {
        return User.player == teamCaptain
    }
    
    static func findOrCreateFriend(teamCaptain: Player, teammate: Player) -> Team {
        let tempFriend = Team(teamCaptain: teamCaptain, teammate: teammate)
        for friend in allFriends{
            if friend == tempFriend{
                return friend
            }
        }
        return tempFriend
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        if(lhs.teamCaptain == rhs.teamCaptain && lhs.teammate == rhs.teammate){
            return true
        }
        return lhs.teamCaptain == rhs.teammate && lhs.teammate == rhs.teamCaptain
    }
    
    static func parseFriends() {
        self.pendingFriends = []
        self.pendingFriendsUsers = []
        self.waitingFriends = []
        self.waitingFriendsUsers = []
        self.nothingFriends = []
        self.nothingFriendsUsers = []
        self.approvedFriends = []
        self.approvedFriendsUsers = []
        self.blockedFriends = []
        self.blockedFriendsUsers = []
        
        for friend in self.allFriends{
            switch friend.status {
            case .ACCEPTED:
                approvedFriends.append(friend)
                approvedFriendsUsers.append(friend.getOtherUser())
            case .PENDING:
                if friend.loggedInUserIsTeamCaptain(){
                    waitingFriends.append(friend)
                    waitingFriendsUsers.append(friend.getOtherUser())
                }
                else{
                    pendingFriends.append(friend)
                    pendingFriendsUsers.append(friend.getOtherUser())
                }
            case .NOTHING:
                nothingFriends.append(friend)
                nothingFriendsUsers.append(friend.getOtherUser())
            case .BLOCKED:
                blockedFriends.append(friend)
                blockedFriendsUsers.append(friend.getOtherUser())
            default:
                print("Friend has invalid status.")
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
