//
//  AuthUser.swift
//  cleanerLife
//
//  Created by Adam Berard on 2/3/21.
//

import Foundation

struct AuthUser : Codable {
    var email : String = ""
    var username : String = ""
    var uuid : String = ""
    var token : String = ""
    
    func getListFriendBasicUsers() -> [BasicUser] {
        var possiblePlayers : [BasicUser] = [self.asBasicUser()]
        for friend in userFriends{
            if friend.teamCaptain.username == currentUser.username{
                possiblePlayers.append(friend.teammate)
            }
            else{
                possiblePlayers.append(friend.teamCaptain)
            }
        }
        return possiblePlayers
    }
    
    func asBasicUser() -> BasicUser {
        let temp = BasicUser()
        temp.username = currentUser.username
        temp.uuid = currentUser.uuid
        return temp
    }
}

class LoginPack : Codable {
    var user : AuthUser
    var games : [Game]
    var friends : [Friend]
    var all_usernames : [String]
}

enum KeychainError: Error {
    case noToken
    case unexpectedTokenData
    case unhandledError(status: OSStatus)
}

class BasicUser : Codable {
    var username : String = ""
    var uuid : String = ""
    
    static func getBasicUser(username: String)  -> BasicUser{
        for basicUser in currentUser.getListFriendBasicUsers() {
            if basicUser.username == username {
                return basicUser
            }
        }
        print("NO BUENO")
        return BasicUser()
    }
}
