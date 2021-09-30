//
//  StatDetailViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/30/21.
//

import UIKit

class StatDetailViewController: UIViewController {
    
    var stat : Stat?
    
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
        
        totalTimesHitLabel.text = String(stat!.totalHits)
        totalTimesHitWinLabel.text = String(stat!.totalWinHits)
        totalTimesHitLossLabel.text = String(stat!.totalLossHits)
        
        totalPointScoredLabel.text = String(stat!.totalPoints)
        totalPointScoredWinLabel.text = String(stat!.totalWinPoints)
        totalPointScoredLossLabel.text = String(stat!.totalLossPoints)
        
        if stat!.averageHits.isNaN { averageTimesHitLabel.text = "NA"}
        else { averageTimesHitLabel.text = String(stat!.averageHits)}
        if stat!.averageWinHits.isNaN { averageTimesHitWinLabel.text = "NA"}
        else { averageTimesHitWinLabel.text = String(stat!.averageWinHits)}
        if stat!.averageLossHits.isNaN { averageTimesHitLossLabel.text = "NA"}
        else { averageTimesHitLossLabel.text = String(stat!.averageLossHits)}
        
        if stat!.averagePoints.isNaN { averagePointsScoredLabel.text = "NA"}
        else { averagePointsScoredLabel.text = String(stat!.averagePoints)}
        if stat!.averageWinPoints.isNaN { averagePointsScoredWinLabel.text = "NA"}
        else { averagePointsScoredWinLabel.text = String(stat!.averageWinPoints)}
        if stat!.averageLossPoints.isNaN { averagePointsScoredLossLabel.text = "NA"}
        else { averagePointsScoredLossLabel.text = String(stat!.averageLossPoints)}
    }
}
