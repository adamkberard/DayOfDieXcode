//
//  Stat.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/29/21.
//

import Foundation

class StatSet {
    static func getStats() -> [Stat] {
        var myStats : [Stat] = []
        myStats.append(getTotalPointsStat())
        myStats.append(getCertainPoint(pointType: .REGULAR))
        myStats.append(getCertainPoint(pointType: .TINK))
        myStats.append(getCertainPoint(pointType: .SINK))
        myStats.append(getCertainPoint(pointType: .BOUNCE_SINK))
        myStats.append(getCertainPoint(pointType: .PARTNER_SINK))
        myStats.append(getCertainPoint(pointType: .SELF_SINK))
        myStats.append(getCertainPoint(pointType: .FIFA))
        myStats.append(getCertainPoint(pointType: .FIELD_GOAL))
        myStats.append(getCertainPoint(pointType: .FIVE))
        myStats.append(getUntrackedPoints())
        return myStats
    }
    
    static func getTotalPointsStat() -> Stat {
        var totalWinHits : Int = 0
        var totalLossHits : Int = 0
        var totalWinPoints : Int = 0
        var totalLossPoints : Int = 0
        var totalWins : Int = 0
        var totalLosses : Int = 0
        
        for game in GameSet.getAllGames() {
            if game.getGameTrackingType() != .GameScore {
                let scoredPoints = game.points.filter { $0.scorer == User.player }
                let totalPointsScored : Int = scoredPoints.reduce(0,  { $0 + $1.getPointValue() })
                if game.didPlayerWin(player: User.player!) {
                    totalWinPoints += totalPointsScored
                    totalWinHits += scoredPoints.count
                    totalWins += 1
                } else {
                    totalLossPoints += totalPointsScored
                    totalLossHits += scoredPoints.count
                    totalLosses += 1
                }
            }
        }
        return Stat(name: "All Points", totalWinHits: totalWinHits, totalWinPoints: totalWinPoints, totalLossHits: totalLossHits, totalLossPoints: totalLossPoints, totalWinGames: totalWins, totalLossGames: totalLosses)
    }
    
    static func getCertainPoint(pointType: PointTypes) -> Stat {
        var totalWinHits : Int = 0
        var totalLossHits : Int = 0
        var totalWinPoints : Int = 0
        var totalLossPoints : Int = 0
        var totalWins : Int = 0
        var totalLosses : Int = 0
        
        for game in GameSet.getAllGames() {
            if game.getGameTrackingType() == .PointScore {
                let scoredPoints = game.points.filter { $0.scorer == User.player && $0.typeOfPoint ==  pointType}
                let totalPointsScored : Int = scoredPoints.reduce(0,  { $0 + $1.getPointValue() })
                if game.didPlayerWin(player: User.player!) {
                    totalWinPoints += totalPointsScored
                    totalWinHits += scoredPoints.count
                    totalWins += 1
                } else {
                    totalLossPoints += totalPointsScored
                    totalLossHits += scoredPoints.count
                    totalLosses += 1
                }
            }
        }
        return Stat(name: "\(pointType)", totalWinHits: totalWinHits, totalWinPoints: totalWinPoints, totalLossHits: totalLossHits, totalLossPoints: totalLossPoints, totalWinGames: totalWins, totalLossGames: totalLosses)
    }
    
    static func getUntrackedPoints() -> Stat {
        var totalWinHits : Int = 0
        var totalLossHits : Int = 0
        var totalWinPoints : Int = 0
        var totalLossPoints : Int = 0
        var totalWins : Int = 0
        var totalLosses : Int = 0
        
        for game in GameSet.getAllGames() {
            if game.getGameTrackingType() == .PlayerScore {
                let scoredPoints = game.points.filter { $0.scorer == User.player }
                let totalPointsScored : Int = scoredPoints.count
                if game.didPlayerWin(player: User.player!) {
                    totalWinPoints += totalPointsScored
                    totalWinHits += scoredPoints.count
                    totalWins += 1
                } else {
                    totalLossPoints += totalPointsScored
                    totalLossHits += scoredPoints.count
                    totalLosses += 1
                }
            }
        }
        return Stat(name: "\(PointTypes.UNTRACKED)", totalWinHits: totalWinHits, totalWinPoints: totalWinPoints, totalLossHits: totalLossHits, totalLossPoints: totalLossPoints, totalWinGames: totalWins, totalLossGames: totalLosses)
    }
}

class Stat : Codable, Searchable {
    var name : String
    
    var totalGames : Int { get { return totalWins + totalLosses}}
    var totalWins : Int
    var totalLosses : Int
    
    var totalHits : Int { get { return totalWinHits + totalLossHits}}
    var totalWinHits : Int
    var totalLossHits : Int
    
    var totalPoints : Int { get { return totalWinPoints + totalLossPoints}}
    var totalWinPoints : Int
    var totalLossPoints : Int
    
    var averageHits : Double { get { return Double(totalHits) / Double(totalGames)}}
    var averageWinHits : Double { get { return Double(totalWinHits) / Double(totalWins)}}
    var averageLossHits : Double { get { return Double(totalLossHits) / Double(totalLosses)}}
    
    var averagePoints : Double { get { return Double(totalPoints) / Double(totalGames)}}
    var averageWinPoints : Double { get { return Double(totalWinPoints) / Double(totalWins)}}
    var averageLossPoints : Double { get { return Double(totalLossPoints) / Double(totalLosses)}}
    
    
    internal init(name: String, totalWinHits: Int, totalWinPoints: Int, totalLossHits: Int, totalLossPoints: Int, totalWinGames: Int, totalLossGames: Int) {
        self.name = name
        self.totalWins = totalWinGames
        self.totalLosses = totalLossGames
        self.totalWinHits = totalWinHits
        self.totalWinPoints = totalWinPoints
        self.totalLossHits = totalLossHits
        self.totalLossPoints = totalLossPoints
    }
    
    func getSearchString() -> String {
        return name
    }
}
