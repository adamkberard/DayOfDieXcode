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
    var teamCaptain : BasicUser
    var teammate : BasicUser
    var uuid : UUID?
    var status : FriendStatuses?
    var wins : Int
    var losses : Int
    
    init(teamCaptain: BasicUser, teammate: BasicUser) {
        self.teamCaptain = teamCaptain
        self.teammate = teammate
        wins = 0
        losses = 0
    }
    
    func getOtherUser() -> BasicUser {
        if(CurrentUser.basicUser == teamCaptain){
            return teammate
        }
        else{
            return teamCaptain
        }
    }
    
    func loggedInUserIsTeamCaptain() -> Bool {
        return CurrentUser.basicUser == teamCaptain
    }
    
    static func findOrCreateFriend(teamCaptain: BasicUser, teammate: BasicUser) -> Friend {
        let tempFriend = Friend(teamCaptain: teamCaptain, teammate: teammate)
        for friend in CurrentUser.friends{
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
    
    enum CodingKeys : String, CodingKey {
        case teamCaptain = "team_captain"
        case teammate
        case uuid
        case wins
        case losses
    }
}
