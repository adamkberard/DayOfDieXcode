//
//  User.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/10/21.
//

import Foundation

class ThisUser : Codable{
    static var token : String = ""
    static var email : String = ""
    static var user : User = User()
}

class User : Codable, Equatable {
    var username : String = ""
    var uuid : String = ""
    var wins : Int = 0
    var losses : Int = 0
    
    convenience init(username: String) {
        self.init()
        self.username = username
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username
    }
}
