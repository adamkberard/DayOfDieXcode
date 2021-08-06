//
//  ViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit

class ChooseRulesViewController: UIViewController, UITextFieldDelegate {
    var playerNames : [String] = []
    @IBOutlet var ruleViews : [RuleRow] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ruleViews[0].mySetup(type: .regular)
        ruleViews[1].mySetup(type: .tink)
        ruleViews[2].mySetup(type: .sink)
        ruleViews[3].mySetup(type: .bounceSink)
        ruleViews[4].mySetup(type: .partnerSink)
        ruleViews[5].mySetup(type: .selfSink)
        ruleViews[6].mySetup(type: .fifa)
        ruleViews[7].mySetup(type: .fieldGoal)
        ruleViews[8].mySetup(type: .five)
        ruleViews[9].mySetup(type: .winBy)
        ruleViews[10].mySetup(type: .playTo)
    }
    
    @IBAction func startGameButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toMainTracking", sender: self)
    }
    
    //MARK: Segue Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toMainTracking" {
                guard let viewController = segue.destination as? MainTrackingViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
    
                
                var ruleDict : Dictionary<RuleTypes, RuleRow> = [:]
                for rule in ruleViews{
                    ruleDict[rule.ruleType] = rule
                }
                viewController.rules = ruleDict
            }
        }
    }
}

