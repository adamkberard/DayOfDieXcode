//
//  SpecialPointsViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/3/21.
//

import UIKit

class SpecialPointsViewController: UIViewController {

    // Player options
    @IBOutlet weak var tinkOptionOne: UILabel!
    @IBOutlet weak var tinkOptionTwo: UILabel!
    @IBOutlet weak var sinkOptionOne: UILabel!
    @IBOutlet weak var sinkOptionTwo: UILabel!
    @IBOutlet weak var bounceSinkOptionOne: UILabel!
    @IBOutlet weak var bounceSinkOptionTwo: UILabel!
    @IBOutlet weak var partnerSinkOption: UILabel!
    @IBOutlet weak var selfSinkOption: UILabel!
    
    // Point amounts
    @IBOutlet weak var tinkOptionOnePointsLabel: UILabel!
    @IBOutlet weak var tinkOptionTwoPointsLabel: UILabel!
    @IBOutlet weak var sinkOptionOnePointsLabel: UILabel!
    @IBOutlet weak var sinkOptionTwoPointsLabel: UILabel!
    @IBOutlet weak var bounceSinkOptionOnePointsLabel: UILabel!
    @IBOutlet weak var bounceSinkOptionTwoPointsLabel: UILabel!
    @IBOutlet weak var partnerSinkPointsLabel: UILabel!
    @IBOutlet weak var selfSinkPointsLabel: UILabel!
    
    @IBOutlet weak var playerTitleLabel: UILabel!
    
    // My Vars

    var tinksOnOptionOne : Int = 0
    var tinksOnOptionTwo : Int = 0
    var sinksOnOptionOne : Int = 0
    var sinksOnOptionTwo : Int = 0
    var bounceSinksOnOptionOne : Int = 0
    var bounceSinksOnOptionTwo : Int = 0
    var partnerSinks : Int = 0
    var selfSinks : Int = 0
    var optionOneName : String = ""
    var optionTwoName : String = ""
    var partnerName : String = ""
    
    var PrevViewController : MainViewController? = nil
    var chosenPlayerNumber = 0
    
    var player : Player? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oponents : [String] = player!.getPlayerOponents()
        optionOneName = oponents[0]
        optionTwoName = oponents[1]
        
        tinkOptionOne.text = optionOneName
        tinkOptionTwo.text = optionTwoName
        sinkOptionOne.text = optionOneName
        sinkOptionTwo.text = optionTwoName
        bounceSinkOptionOne.text = optionOneName
        bounceSinkOptionTwo.text = optionTwoName
        partnerSinkOption.text = partnerName
        selfSinkOption.text = player!.name
        
        tinksOnOptionOne = player!.tinks.filter({$0 == optionOneName}).count
        tinksOnOptionTwo = player!.tinks.filter({$0 == optionTwoName}).count
        print("HERE")
        print(player!.tinks)
        sinksOnOptionOne = player!.sinks.filter({$0 == optionOneName}).count
        sinksOnOptionTwo = player!.sinks.filter({$0 == optionTwoName}).count
        bounceSinksOnOptionOne = player!.bounceSinks.filter({$0 == optionOneName}).count
        bounceSinksOnOptionTwo = player!.bounceSinks.filter({$0 == optionTwoName}).count
        partnerSinks = player!.partnerSinks.count
        selfSinks = player!.selfSinks
        
        updateAllValues()
        
        // Do any additional setup after loading the view.
        playerTitleLabel.text = "Special Points for \(PrevViewController!.game.getChosenPlayer().name)"
    }
    
    // Value control buttons
    @IBAction func tinkOptionOneMinusPressed(_ sender: Any) {
        tinksOnOptionOne = subtractOne(number: tinksOnOptionOne)
        updateAllValues()
    }
    @IBAction func tinkOptionOnePlusPressed(_ sender: Any) {
        tinksOnOptionOne += 1
        updateAllValues()
    }
    @IBAction func tinkOptionTwoMinusPressed(_ sender: Any) {
        tinksOnOptionTwo = subtractOne(number: tinksOnOptionTwo)
        updateAllValues()
    }
    @IBAction func tinkOptionTwoPlusPressed(_ sender: Any) {
        tinksOnOptionTwo += 1
        updateAllValues()
    }
    @IBAction func sinkOptionOneMinusPressed(_ sender: Any) {
        sinksOnOptionOne = subtractOne(number: sinksOnOptionOne)
        updateAllValues()
    }
    @IBAction func sinkOptionOnePlusPressed(_ sender: Any) {
        sinksOnOptionOne += 1
        updateAllValues()
    }
    @IBAction func sinkOptionTwoMinusPressed(_ sender: Any) {
        sinksOnOptionTwo = subtractOne(number: sinksOnOptionTwo)
        updateAllValues()
    }
    @IBAction func sinkOptionTwoPlusPressed(_ sender: Any) {
        sinksOnOptionTwo += 1
        updateAllValues()
    }
    @IBAction func bounceSinkOptionOneMinusPressed(_ sender: Any) {
        bounceSinksOnOptionOne = subtractOne(number: bounceSinksOnOptionOne)
        updateAllValues()
    }
    @IBAction func bounceSinkOptionOnePlusPressed(_ sender: Any) {
        bounceSinksOnOptionOne += 1
        updateAllValues()
    }
    @IBAction func bounceSinkOptionTwoMinusPressed(_ sender: Any) {
        bounceSinksOnOptionTwo = subtractOne(number: bounceSinksOnOptionTwo)
        updateAllValues()
    }
    @IBAction func bounceSinkOptionTwoPlusPressed(_ sender: Any) {
        bounceSinksOnOptionTwo += 1
        updateAllValues()
    }
    @IBAction func partnerMinusPressed(_ sender: Any) {
        partnerSinks = subtractOne(number: partnerSinks)
        updateAllValues()
    }
    @IBAction func partnerPlusPressed(_ sender: Any) {
        partnerSinks += 1
        updateAllValues()
    }
    @IBAction func selfSinkMinusPressed(_ sender: Any) {
        selfSinks = subtractOne(number: selfSinks)
        updateAllValues()
    }
    @IBAction func selfSinkPlusPressed(_ sender: Any) {
        selfSinks += 1
        updateAllValues()
    }
    
    func subtractOne(number: Int) -> Int{
        if(number > 0){
            return number - 1
        }
        else{
            return 0
        }
    }
    
    func updateAllValues() {
        tinkOptionOnePointsLabel.text = String(tinksOnOptionOne)
        tinkOptionTwoPointsLabel.text = String(tinksOnOptionTwo)
        sinkOptionOnePointsLabel.text = String(sinksOnOptionOne)
        sinkOptionTwoPointsLabel.text = String(sinksOnOptionTwo)
        bounceSinkOptionOnePointsLabel.text = String(bounceSinksOnOptionOne)
        bounceSinkOptionTwoPointsLabel.text = String(bounceSinksOnOptionTwo)
        partnerSinkPointsLabel.text = String(partnerSinks)
        selfSinkPointsLabel.text = String(selfSinks)
        
        PrevViewController!.game.getChosenPlayer().tinks = []
        PrevViewController!.game.getChosenPlayer().sinks = []
        PrevViewController!.game.getChosenPlayer().bounceSinks = []
        PrevViewController!.game.getChosenPlayer().partnerSinks = []
        PrevViewController!.game.getChosenPlayer().selfSinks = 0
        
        // Update return values as well
        for _ in 0..<tinksOnOptionOne {
            PrevViewController!.game.getChosenPlayer().tinks.append(optionOneName)}
        for _ in 0..<tinksOnOptionTwo {
            PrevViewController!.game.getChosenPlayer().tinks.append(optionTwoName)}
        for _ in 0..<sinksOnOptionOne {
            PrevViewController!.game.getChosenPlayer().sinks.append(optionOneName)}
        for _ in 0..<sinksOnOptionTwo {
            PrevViewController!.game.getChosenPlayer().sinks.append(optionTwoName)}
        for _ in 0..<bounceSinksOnOptionOne {
            PrevViewController!.game.getChosenPlayer().bounceSinks.append(optionOneName)}
        for _ in 0..<bounceSinksOnOptionTwo{
            PrevViewController!.game.getChosenPlayer().bounceSinks.append(optionTwoName)}
        for _ in 0..<partnerSinks {
            PrevViewController!.game.getChosenPlayer().partnerSinks.append(partnerName)}
        PrevViewController!.game.getChosenPlayer().selfSinks = selfSinks
    }
}
