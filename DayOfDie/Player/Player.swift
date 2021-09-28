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
    
    static func changeUser(oldUsername: String) {
        for i in 0...allPlayers.count - 1 {
            if allPlayers[i].username == oldUsername{
                allPlayers[i].username = User.player.username
            }
        }
    }
    
    static func setSelf() -> Void {
        for player in allPlayers{
            if player.username == User.player.username{
                User.player = player
                break
            }
        }
    }
    
    static func getPlayer(inPlayer : Player) -> Player {
        let player : [Player] = allPlayers.filter { return $0 == inPlayer }
        if player.count == 0 {
            fatalError("Couldn't find \(inPlayer).")
        }
        return player[0]
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.username == rhs.username
    }
    
    func getSearchString() -> String {
        return username
    }
}
