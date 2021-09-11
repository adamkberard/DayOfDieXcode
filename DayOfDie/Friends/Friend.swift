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
}

class Friend : Codable, Equatable {
    static var allFriends : [Friend] = [] {
        didSet{
            self.parseFriends()
        }
    }
    static var approvedFriends : [Friend] = []
    static var approvedFriendsUsers : [User] = []
    static var pendingFriends : [Friend] = []
    static var pendingFriendsUsers : [User] = []
    static var waitingFriends : [Friend] = []
    static var waitingFriendsUsers : [User] = []
    static var nothingFriends : [Friend] = []
    static var nothingFriendsUsers : [User] = []
    
    var teamCaptain : User
    var teammate : User
    var uuid : UUID?
    var status : FriendStatuses?
    var wins : Int
    var losses : Int
    
    init(teamCaptain: User, teammate: User) {
        self.teamCaptain = teamCaptain
        self.teammate = teammate
        wins = 0
        losses = 0
    }
    
    func getOtherUser() -> User {
        if(ThisUser.user == teamCaptain){
            return teammate
        }
        else{
            return teamCaptain
        }
    }
    
    func loggedInUserIsTeamCaptain() -> Bool {
        return ThisUser.user == teamCaptain
    }
    
    static func findOrCreateFriend(teamCaptain: User, teammate: User) -> Friend {
        let tempFriend = Friend(teamCaptain: teamCaptain, teammate: teammate)
        for friend in allFriends{
            if friend == tempFriend{
                return friend
            }
        }
        return tempFriend
    }
    
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        if(lhs.teamCaptain == rhs.teamCaptain && lhs.teammate == rhs.teammate){
            return true
        }
        return lhs.teamCaptain == rhs.teammate && lhs.teammate == rhs.teamCaptain
    }
    
    static func parseFriends() {
        self.pendingFriends = []
        self.waitingFriends = []
        self.nothingFriends = []
        self.approvedFriends = []
        
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
