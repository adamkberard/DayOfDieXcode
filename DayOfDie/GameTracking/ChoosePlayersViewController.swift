//
//  ViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/25/21.
//

import UIKit

class ChoosePlayersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    //Player Text Fields
    @IBOutlet var playerPickers: [UIPickerView]!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var fullStatsSwitch: UISwitch!
    @IBOutlet weak var simpleStatsSwitch: UISwitch!
    @IBOutlet weak var justScoreSwitch: UISwitch!
    var players : [Player] = []
    
    var possiblePlayers : [Player] = []
    
    override func viewWillAppear(_ animated: Bool) {
        setupPickers()
        setPlayers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        for playerPicker in playerPickers{
            playerPicker.dataSource = self
            playerPicker.delegate = self
        }
    }
    
    func setupPickers() {
        possiblePlayers = []
        possiblePlayers.append(User.player)
        possiblePlayers.append(contentsOf: Team.approvedTeams.map({$0.getOtherUser()}))
        for playerPicker in playerPickers {
            playerPicker.reloadComponent(0)
        }
        print("Current possible players: \(possiblePlayers.count)")
        
        if(possiblePlayers.count < 4){
            for playerPicker in playerPickers{
                playerPicker.isUserInteractionEnabled = false
            }
            startGameButton.isEnabled = false
            statusLabel.isHidden = false
            statusLabel.text = "Must have at least three friends to start a game."
        }
        else {
            for i in 0...3{
                playerPickers[i].isUserInteractionEnabled = true
                playerPickers[i].selectRow(i, inComponent: 0, animated: false)
            }
            if pickerSelectionsAreGood(){
                startGameButton.isEnabled = true
                statusLabel.isHidden = true
            }
            else{
                startGameButton.isEnabled = false
                statusLabel.isHidden = false
                statusLabel.text = "Must have four unique players."
            }
        }
    }
    
    func pickerSelectionsAreGood() -> Bool {
        // We go through each one
        for playerPickerOne in playerPickers {
            for playerPickerTwo in playerPickers {
                if playerPickerOne != playerPickerTwo {
                    if playerPickerOne.selectedRow(inComponent: 0) == playerPickerTwo.selectedRow(inComponent: 0) {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    @IBAction func startGameTracking(_ sender: Any) {
        // First I will make sure none of the people are duplicates
        if pickerSelectionsAreGood() {
            if fullStatsSwitch.isOn {
                self.performSegue(withIdentifier: "toFullStatsTracking", sender: self)
            }
            if simpleStatsSwitch.isOn {
                self.performSegue(withIdentifier: "toSimpleStatsTracking", sender: self)
            }
            if justScoreSwitch.isOn {
                self.performSegue(withIdentifier: "toJustScoreTracking", sender: self)
            }
        }
    }
    
    //MARK: Picker Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Taking away three from the other three pickers
        if possiblePlayers.count < 4 {
            return 1
        }
        return possiblePlayers.count
    }
    
    // Telling the picker's what to display
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // We start with a list of our friends, but only allow ones that are verified? At least for now...
        if possiblePlayers.count < 4 {
            return ""
        }
        
        return possiblePlayers[row].username
    }
    
    // When any of the pickers are selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerSelectionsAreGood(){
            startGameButton.isEnabled = true
            statusLabel.isHidden = true
        }
        else{
            startGameButton.isEnabled = false
            statusLabel.isHidden = false
            statusLabel.text = "Must have four unique players."
        }
        setPlayers()
    }
    
    func setPlayers() -> Void {
        players = []
        for i in 0...3{
            players.append(possiblePlayers[playerPickers[i].selectedRow(inComponent: 0)])
        }
    }
    
    @IBAction func fullStatsSwitchChanged(_ sender: Any) {
        if fullStatsSwitch.isOn{
            simpleStatsSwitch.isOn = false
            justScoreSwitch.isOn = false
        }
        else {
            if simpleStatsSwitch.isOn == false && justScoreSwitch.isOn == false {
                fullStatsSwitch.isOn = true
            }
        }
    }

    @IBAction func simpleStatsSwitchChanged(_ sender: Any) {
        if simpleStatsSwitch.isOn {
            fullStatsSwitch.isOn = false
            justScoreSwitch.isOn = false
        }
        else {
            if fullStatsSwitch.isOn == false && justScoreSwitch.isOn == false {
                simpleStatsSwitch.isOn = true
            }
        }
    }
    
    @IBAction func justScoreSwitchChanged(_ sender: Any) {
        if justScoreSwitch.isOn {
            fullStatsSwitch.isOn = false
            simpleStatsSwitch.isOn = false
        }
        else {
            if fullStatsSwitch.isOn == false && simpleStatsSwitch.isOn == false {
                justScoreSwitch.isOn = true
            }
        }
    }
    //MARK: Segue Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toFullStatsTracking" {
                guard let viewController = segue.destination as? FullStatsTrackingViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                viewController.players = players
            }
            else if identifier == "toSimpleStatsTracking" {
                guard let viewController = segue.destination as? SimpleStatsTrackingViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                viewController.players = players
            }
            else if identifier == "toJustScoreTracking" {
                guard let viewController = segue.destination as? JustScoreTrackingViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                print("HERE DUH")
                viewController.players = players
            }
        }
    }
}
