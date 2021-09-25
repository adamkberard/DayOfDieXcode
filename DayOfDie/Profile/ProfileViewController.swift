//
//  ProfileViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/12/21.
//

import UIKit

class ProfileViewController: PlayerViewController, UITextFieldDelegate {
    @IBOutlet weak var requestsButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var changeUsernameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        self.title = User.player.username
    }
    
    override func setRawObjectList() -> [Game] { return Game.allGames }
    override func setObjectList(rawList: [Game]) -> [Game] {
        Game.allGames = rawList
        return rawList
    }
    override func setCellIdentifiers() -> [String] { return ["GameCell"] }
    override func setTableSegueIdentifier() -> String { return "toGameDetail" }
    override func setFetchURLEnding() -> String { return "/games/" }
    override func setRefreshTitleString() -> String { "Fetching Game Data..." }
    
    override func setTeamStatusLabelAndButton() {
        
    }
    
    @IBAction func requestsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "toTeamRequests", sender: self)
    }
    
    @IBAction func changeUsernameButtonPressed(_ sender: Any) {
        if usernameTextField.isHidden {
            usernameLabel.isHidden = true
            usernameTextField.isHidden = false
            usernameTextField.becomeFirstResponder()
        } else {
            usernameTextField.resignFirstResponder()
            let beforeUsername : String = User.player.username
            let parameters : [String: Any] = ["username": usernameTextField.text as Any]
            APICalls.changeUsername(parameters: parameters) { status, returnData in
                if status{
                    User.player = returnData as! Player
                    self.title = User.player.username
                    self.player = User.player
                    // Have to update every list we have
                    Player.changeUser(oldUsername: beforeUsername)
                    self.tableView.reloadData()
                    self.myRefreshControl.endRefreshing()
                }
                else{
                    self.myRefreshControl.endRefreshing()
                    let errors : [String] = returnData as! [String]
                    print(errors)
                    // Alert Stuff
                    let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    // Change username back to before
                    self.usernameLabel.text = beforeUsername
                }
            }
            usernameLabel.text = usernameTextField.text
            usernameLabel.isHidden = false
            usernameTextField.isHidden = true
            changeUsernameButton.isEnabled = true
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        print(usernameTextField.text as Any)
        changeUsernameButtonPressed(self)
        return true
    }
}
