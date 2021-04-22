//
//  Point.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/26/21.
//

import UIKit

enum PointTypes : String, Codable {
    case REGULAR = "ru"
    case TINK = "tk"
    case SINK = "sk"
    case BOUNCE_SINK = "bs"
    case PARTNER_SINK = "ps"
    case SELF_SINK = "ss"
    case FIFA = "ff"
    case FIELD_GOAL = "fg"
}


class Point : Codable {
    var uuid : UUID?
    var typeOfPoint : PointTypes
    var scorer : BasicUser
    var scoredOn : BasicUser?
    var scoredOnPosition : Int?
    var game : UUID?
    
    init(typeOfPoint : PointTypes, scorer : BasicUser, scoredOn : BasicUser?, scoredOnPosition : Int?){
        self.typeOfPoint = typeOfPoint
        self.scorer = scorer
        self.scoredOn = scoredOn
        self.scoredOnPosition = scoredOnPosition
    }
    
    static func getScore(points: [Point]) -> Int {
        var score : Int = 0
        for point in points{
            if point.typeOfPoint == .REGULAR{
                score += 1
            }
            else if point.typeOfPoint == .TINK{
                score += 2
            }
            else if point.typeOfPoint == .SINK{
                score += 3
            }
            else if point.typeOfPoint == .BOUNCE_SINK{
                score += 2
            }
        }
        return score
    }
    
    func getString() -> String {
        switch typeOfPoint {
        case .REGULAR:
            return "\(scorer.username) got a point."
        case .TINK:
            return "\(scorer.username) tinked \(scoredOn?.username ?? "")."
        case .SINK:
            return "\(scorer.username) sank \(scoredOn?.username ?? "")."
        case .BOUNCE_SINK:
            return "\(scorer.username) bounce sank \(scoredOn?.username ?? "")."
        case .PARTNER_SINK:
            return "\(scorer.username) partner sank \(scoredOn?.username ?? "")."
        case .SELF_SINK:
            return "\(scorer.username) self sank."
        case .FIFA:
            return "\(scorer.username) fifa'ed \(scoredOn?.username ?? "")."
        case .FIELD_GOAL:
            return "\(scorer.username) got a field goal."
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case uuid
        case typeOfPoint = "type"
        case scorer
        case scoredOn
        case scoredOnPosition = "scored_on_position"
        case game
    }
}
