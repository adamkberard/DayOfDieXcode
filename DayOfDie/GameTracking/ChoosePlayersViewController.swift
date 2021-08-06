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

    override func viewDidLoad() {
        super.viewDidLoad()
 
        for playerPicker in playerPickers{
            playerPicker.dataSource = self
            playerPicker.delegate = self
            playerPicker.selectRow(playerPickers.firstIndex(of: playerPicker) ?? 0, inComponent: 0, animated: false)
        }

        markBadPickers()
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
        // Gotta add one for me.
        return CurrentUser.approvedFriends.count + 1
    }
    
    // Telling the picker's what to display
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // We start with a list of our friends, but only allow ones that are verified? At least for now...
        var tempFriends : [BasicUser] = CurrentUser.approvedFriends.map({$0.getOtherUser()})
        tempFriends.append(CurrentUser.basicUser)
        return tempFriends[row].username
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
            /*
            if identifier == "toRulePicking" {
                guard let viewController = segue.destination as? ChooseRulesViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                for i in (0...3){
                    viewController.playerNames.append(CurrentUser.getListFriendBasicUsers()[playerPickers[i].selectedRow(inComponent: 0)].username) 
                }
            }*/
            if identifier == "toScoreTracking" {
                guard let viewController = segue.destination as? MainTrackingViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                for i in (0...3){
                    viewController.playerNames.append(CurrentUser.getListFriendBasicUsers()[playerPickers[i].selectedRow(inComponent: 0)].username)
                }
            }
        }
    }
}
