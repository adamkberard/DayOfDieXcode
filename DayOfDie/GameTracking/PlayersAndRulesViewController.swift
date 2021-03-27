//
//  ViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit

class PlayersAndRulesViewController: UIViewController {
    
    //Player Text Fields
    @IBOutlet var playerTextFields: [UITextField]!

    // Point Switches
    @IBOutlet weak var regularPointSwitch: UISwitch!
    @IBOutlet weak var tinkPointSwitch: UISwitch!
    @IBOutlet weak var sinkPointSwitch: UISwitch!
    @IBOutlet weak var bounceSinkPointSwitch: UISwitch!
    @IBOutlet weak var partnerSinkPointSwitch: UISwitch!
    @IBOutlet weak var selfSinkPointSwitch: UISwitch!
    @IBOutlet weak var fifaPointSwitch: UISwitch!
    @IBOutlet weak var fieldGoalPointSwitch: UISwitch!
    
    // Minus Buttons
    @IBOutlet weak var regularPointMinus: UIButton!
    @IBOutlet weak var tinkPointMinus: UIButton!
    @IBOutlet weak var sinkPointMinus: UIButton!
    @IBOutlet weak var bounceSinkPointMinus: UIButton!
    @IBOutlet weak var partnerSinkPointMinus: UIButton!
    @IBOutlet weak var selfSinkPointMinus: UIButton!
    @IBOutlet weak var fifaPointMinus: UIButton!
    @IBOutlet weak var fieldGoalPointMinus: UIButton!
    
    //
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toMainTracking" {
                guard let viewController = segue.destination as? MainTrackingViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                //viewController.player = game.getChosenPlayer()
            }
        }
    }
}
