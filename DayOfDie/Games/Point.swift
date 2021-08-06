//
//  Point.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/26/21.
//

import UIKit

enum PointTypes : String, Codable {
    case REGULAR = "sg"
    case TINK = "tk"
    case SINK = "sk"
    case BOUNCE_SINK = "bs"
    case PARTNER_SINK = "ps"
    case SELF_SINK = "ss"
    case FIFA = "ff"
    case FIELD_GOAL = "fg"
    case FIVE = "fv"
}


class Point : Codable {
    var uuid : UUID?
    var typeOfPoint : PointTypes
    var scorer : BasicUser
    var game : UUID?
    
    init(typeOfPoint : PointTypes, scorer : BasicUser){
        self.typeOfPoint = typeOfPoint
        self.scorer = scorer
    }
    
    static func getScore(points: [Point]) -> Int {
        var score : Int = 0
        for point in points{
            switch point.typeOfPoint {
            case .REGULAR:
                score += 1
            case .TINK:
                score += 2
            case .SINK:
                score += 3
            case .BOUNCE_SINK:
                score += 2
            case .PARTNER_SINK:
                score += 0
            case .SELF_SINK:
                score -= 0
            case .FIFA:
                score += 1
            case .FIELD_GOAL:
                score += 1
            case .FIVE:
                score += 0
            }
        }
        return score
    }
    
    static func getScore(points: [Point], rules: Dictionary<RuleTypes, RuleRow>) -> Int {
        var score : Int = 0
        var tempRuleType : RuleTypes = .regular
        
        for point in points {
            switch point.typeOfPoint {
            case .REGULAR:
                tempRuleType = .regular
            case .TINK:
                tempRuleType = .tink
            case .SINK:
                tempRuleType = .sink
            case .BOUNCE_SINK:
                tempRuleType = .bounceSink
            case .PARTNER_SINK:
                tempRuleType = .partnerSink
            case .SELF_SINK:
                tempRuleType = .selfSink
            case .FIFA:
                tempRuleType = .fifa
            case .FIELD_GOAL:
                tempRuleType = .fieldGoal
            case .FIVE:
                tempRuleType = .five
            }
            
            let tempRule : RuleRow? = rules[tempRuleType]
            
            if tempRule != nil {
                score += tempRule!.points
            }
        }
        return score
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
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case uuid
        case typeOfPoint = "type"
        case scorer
        case game
    }
}
