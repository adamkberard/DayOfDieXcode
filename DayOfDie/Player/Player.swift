//
//  User.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/10/21.
//

import Foundation

class User : Codable{
    static var token : String = ""
    static var email : String = ""
    static var player : Player = Player()
}

class Player : Codable, Equatable, Searchable {
    static var allPlayers : [Player] = [] {
        didSet {
            setSelf()
        }
    }
    
    var username : String = ""
    var uuid : String = ""
    var wins : Int = 0
    var losses : Int = 0
    
    convenience init(username: String) {
        self.init()
        self.username = username
    }
    
    static func setSelf() -> Void {
        for player in allPlayers{
            if player.username == User.player.username{
                User.player = player
                break
            }
        }
    }
    
    static func getPlayer(inPlayer : Player) -> Player? {
        for player in self.allPlayers{
            if player == inPlayer {
                return player
            }
        }
        return nil
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.username == rhs.username
    }
    
    func getSearchString() -> String {
        return username
    }
}
