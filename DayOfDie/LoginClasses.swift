//
//  AuthUser.swift
//  cleanerLife
//
//  Created by Adam Berard on 2/3/21.
//

import Foundation
import Alamofire

class CurrentUser : Codable{
    static var username : String = "" {
        didSet {
            self.basicUser.username = username
        }
    }
    static var uuid : String = "" {
        didSet {
            self.basicUser.uuid = uuid
        }
    }
    
    static var email : String = ""
    static var token : String = ""
    static var games : [Game] = []
    static var friends : [Friend] = [] {
        didSet {
            parseFriends()
        }
    }
    
    static var approvedFriends : [Friend] = []
    static var approvedFriendsAsBasicUsers : [BasicUser] = []
    static var pendingFriends : [Friend] = []
    static var pendingFriendsAsBasicUsers : [BasicUser] = []
    static var waitingFriends : [Friend] = []
    static var waitingFriendsAsBasicUsers : [BasicUser] = []
    static var nothingFriends : [Friend] = []
    static var nothingFriendsAsBasicUsers : [BasicUser] = []
    
    static var basicUser = BasicUser()
    
    static func getListFriendBasicUsers() -> [BasicUser] {
        var possiblePlayers : [BasicUser] = [self.basicUser]
        for friend in self.friends{
            if friend.teamCaptain.username == self.basicUser.username{
                possiblePlayers.append(friend.teammate)
            }
            else{
                possiblePlayers.append(friend.teamCaptain)
            }
        }
        return possiblePlayers
    }
    
    static func getHeaders()->HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Token \(CurrentUser.token)",
        ]
        return headers
    }
    
    static func parseFriends() {
        self.approvedFriends = []
        self.approvedFriendsAsBasicUsers = []
        self.pendingFriends = []
        self.pendingFriendsAsBasicUsers = []
        self.waitingFriends = []
        self.waitingFriendsAsBasicUsers = []
        self.nothingFriends = []
        self.nothingFriendsAsBasicUsers = []
        
        for friend in friends{
            switch friend.status {
            case .ACCEPTED:
                approvedFriends.append(friend)
                approvedFriendsAsBasicUsers.append(friend.getOtherUser())
            case .PENDING:
                if friend.loggedInUserIsTeamCaptain(){
                    waitingFriends.append(friend)
                    waitingFriendsAsBasicUsers.append(friend.getOtherUser())
                }
                else{
                    pendingFriends.append(friend)
                    pendingFriendsAsBasicUsers.append(friend.getOtherUser())
                }
            case .NOTHING:
                nothingFriends.append(friend)
                nothingFriendsAsBasicUsers.append(friend.getOtherUser())
            default:
                print("Someday I'll deal with this.")
            }
        }
    }
}

class LoginPack : Codable {
    var user : AuthUser
    var games : [Game]
    var friends : [Friend]
    var all_users : [BasicUser]
}

class AuthUser : Codable {
    var email : String = ""
    var username : String = ""
    var uuid : String = ""
    var wins : Int = 0
    var losses : Int = 0
    var token : String = ""
}

class FullUser : Codable {
    var username : String = ""
    var uuid : String = ""
    var wins : Int = 0
    var losses : Int = 0
}

enum KeychainError: Error {
    case noToken
    case unexpectedTokenData
    case unhandledError(status: OSStatus)
}

var allUsers : [BasicUser] = []

class BasicUser : Codable, Equatable {
    var username : String = ""
    var uuid : String = ""
    
    convenience init(username: String) {
        self.init()
        self.username = username
    }
    
    static func getBasicUser(username: String)  -> BasicUser {
        for basicUser in CurrentUser.getListFriendBasicUsers() {
            if basicUser.username == username {
                return basicUser
            }
        }
        return BasicUser()
    }
    
    static func == (lhs: BasicUser, rhs: BasicUser) -> Bool {
        return lhs.username == rhs.username
    }
}
