//
//  GameClasses.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/4/21.
//

import UIKit

enum StatTypes {
    case scoreOnly
    case regularStats
    case fullStats
}

class Game {
    var id : String?
    var statType : StatTypes
    var timeStarted : Date
    var timeSaved : Date?
    var players : [Player]
    var points : [Point]
    
    init(statType: StatTypes, players: [Player]) {
        self.statType = statType
        self.timeStarted = Date()
        self.players = players
        self.points = []
    }
}
