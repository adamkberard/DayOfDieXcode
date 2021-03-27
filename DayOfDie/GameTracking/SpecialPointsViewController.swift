//
//  SpecialPointsViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/3/21.
//

import UIKit

class SpecialPointsViewController: UIViewController {

    @IBOutlet weak var playerTitleLabel: UILabel!
    
    //var PrevViewController : MainTrackingViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //playerTitleLabel.text = "Special Points for \(PrevViewController!.game.getChosenPlayer().name)"
    }
    
    func subtractOne(number: Int) -> Int{
        if(number > 0){
            return number - 1
        }
        else{
            return 0
        }
    }
}
