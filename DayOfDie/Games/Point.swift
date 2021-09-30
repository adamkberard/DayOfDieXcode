//
//  Point.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/26/21.
//

import UIKit

enum PointTypes : String, Codable, CustomStringConvertible {
    case REGULAR = "sg"
    case TINK = "tk"
    case SINK = "sk"
    case BOUNCE_SINK = "bs"
    case PARTNER_SINK = "ps"
    case SELF_SINK = "ss"
    case FIFA = "ff"
    case FIELD_GOAL = "fg"
    case FIVE = "fv"
    case UNTRACKED = "ut"
    
    var description: String {
        switch self {
        case .REGULAR: return "Regular Point"
        case .TINK: return "Tink"
        case .SINK: return "Sink"
        case .BOUNCE_SINK: return "Bounce Sink"
        case .PARTNER_SINK: return "Partner Sink"
        case .SELF_SINK: return "Self Sink"
        case .FIFA: return "Fifa"
        case .FIELD_GOAL: return "Field Goal"
        case .FIVE: return "Five"
        case .UNTRACKED: return "Untracked'"
        }
    }
}


class Point : Codable {
    var uuid : UUID?
    var typeOfPoint : PointTypes
    var scorer : Player
    var game : UUID?
    
    init(typeOfPoint : PointTypes, scorer : Player){
        self.typeOfPoint = typeOfPoint
        self.scorer = scorer
    }
    
    static func getScore(points: [Point]) -> Int {
        var score : Int = 0
        for point in points{
            score += point.getPointValue()
        }
        return score
    }
    
    func getPointValue() -> Int {
        switch typeOfPoint {
        case .REGULAR:
            return 1
        case .TINK:
            return 2
        case .SINK:
            return 3
        case .BOUNCE_SINK:
            return 2
        case .PARTNER_SINK:
            return 0
        case .SELF_SINK:
            return 0
        case .FIFA:
            return 1
        case .FIELD_GOAL:
            return 1
        case .FIVE:
            return 0
        case .UNTRACKED:
            return 1
        }
    }
    
    func getString() -> String {
        switch typeOfPoint {
        case .REGULAR:
            return "\(scorer.username) got a point."
        case .TINK:
            return "\(scorer.username) got a tink."
        case .SINK:
            return "\(scorer.username) got a sink."
        case .BOUNCE_SINK:
            return "\(scorer.username) got a bounce sink."
        case .PARTNER_SINK:
            return "\(scorer.username) got a partner sink."
        case .SELF_SINK:
            return "\(scorer.username) self sank."
        case .FIFA:
            return "\(scorer.username) got a fifa."
        case .FIELD_GOAL:
            return "\(scorer.username) got a field goal."
        case .FIVE:
            return "\(scorer.username) got a five."
        case .UNTRACKED:
            return "\(scorer.username) scored."
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case uuid
        case typeOfPoint = "type"
        case scorer
        case game
    }
}
