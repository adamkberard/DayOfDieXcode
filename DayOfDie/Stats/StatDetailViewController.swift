//
//  StatDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/30/21.
//

import UIKit

class StatDetailViewController: UIViewController {
    
    var stat : Stat?
    
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    @IBOutlet weak var totalLossesLabel: UILabel!
    
    @IBOutlet weak var totalTimesHitLabel: UILabel!
    @IBOutlet weak var totalTimesHitWinLabel: UILabel!
    @IBOutlet weak var totalTimesHitLossLabel: UILabel!
    
    @IBOutlet weak var totalPointScoredLabel: UILabel!
    @IBOutlet weak var totalPointScoredWinLabel: UILabel!
    @IBOutlet weak var totalPointScoredLossLabel: UILabel!
    
    @IBOutlet weak var averageTimesHitLabel: UILabel!
    @IBOutlet weak var averageTimesHitWinLabel: UILabel!
    @IBOutlet weak var averageTimesHitLossLabel: UILabel!
    
    @IBOutlet weak var averagePointsScoredLabel: UILabel!
    @IBOutlet weak var averagePointsScoredWinLabel: UILabel!
    @IBOutlet weak var averagePointsScoredLossLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = stat?.name
        
        totalGamesLabel.text = String(stat!.totalGames)
        totalWinsLabel.text = String(stat!.totalWins)
        totalLossesLabel.text = String(stat!.totalLosses)
        
        totalTimesHitLabel.text = String(stat!.totalHits)
        totalTimesHitWinLabel.text = String(stat!.totalWinHits)
        totalTimesHitLossLabel.text = String(stat!.totalLossHits)
        
        totalPointScoredLabel.text = String(stat!.totalPoints)
        totalPointScoredWinLabel.text = String(stat!.totalWinPoints)
        totalPointScoredLossLabel.text = String(stat!.totalLossPoints)
        
        if stat!.averageHits.isNaN { averageTimesHitLabel.text = "NA"}
        else { averageTimesHitLabel.text = String(stat!.averageHits.rounded(toPlaces: 2))}
        if stat!.averageWinHits.isNaN { averageTimesHitWinLabel.text = "NA"}
        else { averageTimesHitWinLabel.text = String(stat!.averageWinHits.rounded(toPlaces: 2))}
        if stat!.averageLossHits.isNaN { averageTimesHitLossLabel.text = "NA"}
        else { averageTimesHitLossLabel.text = String(stat!.averageLossHits.rounded(toPlaces: 2))}
        
        if stat!.averagePoints.isNaN { averagePointsScoredLabel.text = "NA"}
        else { averagePointsScoredLabel.text = String(stat!.averagePoints.rounded(toPlaces: 2))}
        if stat!.averageWinPoints.isNaN { averagePointsScoredWinLabel.text = "NA"}
        else { averagePointsScoredWinLabel.text = String(stat!.averageWinPoints.rounded(toPlaces: 2))}
        if stat!.averageLossPoints.isNaN { averagePointsScoredLossLabel.text = "NA"}
        else { averagePointsScoredLossLabel.text = String(stat!.averageLossPoints.rounded(toPlaces: 2))}
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
