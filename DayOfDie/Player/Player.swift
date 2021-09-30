//
//  User.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/10/21.
//

import Foundation

class User : Player {
    static var token : String = ""
    static var email : String = ""
    static var player : Player?
}

class PlayerSet {
    private static var allPlayers : [Player] = []
    
    static func getAllPlayers() -> [Player] {
        return allPlayers
    }
    
    static func updateAllPlayers(playerList: [Player]) {
        for inPlayer in playerList {
            let match = allPlayers.filter { return $0 == inPlayer }
            // This means the inPlayer already exists
            if match.count == 1 {
                updatePlayer(masterPlayer: match.first!, referencePlayer: inPlayer)
            }
            else {
                if match.count > 1 {
                    fatalError("This player was in there more than once: \(inPlayer.username)")
                } else {
                    // This means the inPlayer doesn't exist so it's new
                    allPlayers.append(inPlayer)
                }
            }
        }
    }
    
    static func updatePlayer(masterPlayer: Player, referencePlayer: Player) {
        masterPlayer.username = referencePlayer.username
        masterPlayer.wins = referencePlayer.wins
        masterPlayer.losses = referencePlayer.losses
    }
    
    static func getPlayer(inPlayer: Player) -> Player {
        // Must deal with what happens if the player is not there...
        for player in allPlayers {
            if player == inPlayer {
                return player
            }
        }
        // If we come accross a user we don't know, they'll have a uuid so that's fine
        // I just gotta add them to my master list and then return them
        allPlayers.append(inPlayer)
        return getPlayer(inPlayer: inPlayer)
    }
}

class Player : Codable, Equatable, Searchable {
    
    var username : String
    var uuid : String
    var wins : Int = 0
    var losses : Int = 0
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func getSearchString() -> String {
        return username
    }
}
