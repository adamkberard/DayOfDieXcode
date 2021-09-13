//
//  ScoreNames.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import Foundation

class ScoreNames {
    func getScoreName(scoreOne: Int, scoreTwo: Int) -> String {
        switch scoreOne {
            case 0: return zeroScores(otherScore: scoreTwo)
            case 1: return oneScores(otherScore: scoreTwo)
            case 2: return twoScores(otherScore: scoreTwo)
            case 3: return threeScores(otherScore: scoreTwo)
            case 4: return fourScores(otherScore: scoreTwo)
            case 5: return fiveScores(otherScore: scoreTwo)
            case 6: return sixScores(otherScore: scoreTwo)
            case 7: return sevenScores(otherScore: scoreTwo)
            case 8: return eightScores(otherScore: scoreTwo)
            case 9: return nineScores(otherScore: scoreTwo)
            case 10: return tenScores(otherScore: scoreTwo)
            default: return "\(scoreOne)-\(scoreTwo)"
        }
    }
    
    private func zeroScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "O's"
        case 1: return "One"
        case 2: return "Two"
        case 3: return "Three"
        case 4: return "Four"
        case 5: return "Five"
        case 6: return "Six"
        case 7: return "Seven"
        case 8: return "Eight"
        case 9: return "Nine"
        case 10: return "Ten"
        default: return "0 - \(otherScore)"
        }
    }
    private func oneScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Ten"
        case 1: return "Couple Ones"
        default: return "0 - \(otherScore)"
        }
    }
    
    private func twoScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Twenty"
        case 2: return "Dubs"
        default: return "0 - \(otherScore)"
        }
    }
    
    private func threeScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Thirty"
        case 3: return "Thirds"
        default: return "0 - \(otherScore)"
        }
    }
    private func fourScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Fourty"
        case 2: return "Jackie Robinson"
        case 4: return "Forces"
        default: return "0 - \(otherScore)"
        }
    }
    private func fiveScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Fifty"
        case 5: return "Big City Biddies"
        default: return "0 - \(otherScore)"
        }
    }
    private func sixScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Sixty"
        case 6: return "Big City Cities"
        default: return "0 - \(otherScore)"
        }
    }
    private func sevenScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Seventy"
        case 6: return "Mediocre Gas Station"
        case 7: return "Seddies"
        default: return "0 - \(otherScore)"
        }
    }
    private func eightScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Eighty"
        case 8: return "Eddies"
        default: return "0 - \(otherScore)"
        }
    }
    private func nineScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Ninety"
        case 9: return "Brooklyn"
        default: return "0 - \(otherScore)"
        }
    }
    private func tenScores(otherScore: Int) -> String {
        switch otherScore {
        case 0: return "Hundred"
        case 10: return "Tendies"
        default: return "0 - \(otherScore)"
        }
    }
}
