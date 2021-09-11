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
    
    var possiblePlayers : [User] = []
    
    override func viewWillAppear(_ animated: Bool) {
        setupPickers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        for playerPicker in playerPickers{
            playerPicker.dataSource = self
            playerPicker.delegate = self
        }
        
        setupPickers()
    }
    
    func setupPickers() {
        possiblePlayers = []
        possiblePlayers.append(ThisUser.user)
        possiblePlayers.append(contentsOf: Friend.approvedFriends.map({$0.getOtherUser()}))
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
            self.performSegue(withIdentifier: "toScoreTracking", sender: self)
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
    }

    //MARK: Segue Function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toScoreTracking" {
                guard let viewController = segue.destination as? MainTrackingViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                viewController.playerOne = possiblePlayers[playerPickers[0].selectedRow(inComponent: 0)]
                print("HERE 1")
                print(possiblePlayers[playerPickers[0].selectedRow(inComponent: 0)].username)
                viewController.playerTwo = possiblePlayers[playerPickers[1].selectedRow(inComponent: 0)]
                viewController.playerThree = possiblePlayers[playerPickers[2].selectedRow(inComponent: 0)]
                viewController.playerFour = possiblePlayers[playerPickers[3].selectedRow(inComponent: 0)]
            }
        }
    }
}
