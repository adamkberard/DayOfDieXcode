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
    
    var possiblePlayers : [BasicUser] = []
    
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
        possiblePlayers.append(contentsOf: CurrentUser.approvedFriends.map({$0.getOtherUser()}))
        possiblePlayers.append(CurrentUser.basicUser)
        
        if(possiblePlayers.count < 4){
            for playerPicker in playerPickers{
                playerPicker.isUserInteractionEnabled = false
            }
            startGameButton.isEnabled = false
        }
    }
    
    func getSamePickers() -> [UIPickerView] {
        // List of the picker views with the same thing selected
        var sameSelected : [UIPickerView] = []
        
        // We go through each one
        for playerPickerOne in playerPickers {
            for playerPickerTwo in playerPickers {
                if playerPickerOne != playerPickerTwo {
                    if playerPickerOne.selectedRow(inComponent: 0) == playerPickerTwo.selectedRow(inComponent: 0) {
                        sameSelected.append(contentsOf: [playerPickerOne, playerPickerTwo])
                    }
                }
            }
        }
        // Gets uniques
        return Array(Set(sameSelected))
    }
    
    @IBAction func startGameTracking(_ sender: Any) {
        // First I will make sure none of the people are duplicates
        if getSamePickers().count == 0 {
            self.performSegue(withIdentifier: "toScoreTracking", sender: self)
        }
        else{
            print("DIDNT WORK BECAUSE \(getSamePickers().count)")
        }
    }
    
    func markBadPickers() {
        let samePickers = getSamePickers()
        let okayPickers = Array(Set(playerPickers).subtracting(samePickers))
        for picker in samePickers{
            picker.backgroundColor = UIColor.red
        }
        for picker in okayPickers{
            picker.backgroundColor = UIColor.white
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
        return possiblePlayers.count - 3
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
        markBadPickers()
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
                viewController.playerTwo = possiblePlayers[playerPickers[1].selectedRow(inComponent: 0)]
                viewController.playerThree = possiblePlayers[playerPickers[2].selectedRow(inComponent: 0)]
                viewController.playerFour = possiblePlayers[playerPickers[3].selectedRow(inComponent: 0)]
            }
        }
    }
}
