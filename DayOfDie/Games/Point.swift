//
//  Point.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/26/21.
//

import Foundation

enum PointTypes {
    case regular
    case tink
    case sink
    case bounceSink
    case partnerSink
    case selfSink
    case fifa
    case fieldGoal
}

class Point {
    var typeOfPoint : PointTypes
    var scorer : Player
    var scoredOn : Player?
    
    init(typeOfPoint : PointTypes, scorer : Player, scoredOn : Player?){
        self.typeOfPoint = typeOfPoint
        self.scorer = scorer
        self.scoredOn = scoredOn
    }
}
