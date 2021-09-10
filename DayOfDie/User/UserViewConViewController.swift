//
//  UserViewConViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 8/6/21.
//

import UIKit
import Alamofire

class UserViewConViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var totalGamesLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    @IBOutlet weak var totalLossesLabel: UILabel!
    @IBOutlet weak var newUsernameTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    var totalGames = 0 {
        didSet{
            totalGamesLabel.text = String(totalGames)
        }
    }
    var totalWins = 0 {
        didSet{
            totalWinsLabel.text = String(totalWins)
            totalGames = totalWins + totalLosses
        }
    }
    var totalLosses = 0 {
        didSet{
            totalLossesLabel.text = String(totalLosses)
            totalGames = totalWins + totalLosses
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        usernameLabel.text = LoggedInUser.user.username
        emailLabel.text = LoggedInUser.email
        
        updateWinsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateWinsData()
    }
    
    func updateWinsData(){
        totalWins = 0
        totalLosses = 0
        for friend in Friend.approvedFriends{
            totalWins += friend.wins
            totalLosses += friend.losses
        }
    }
    
    @IBAction func changeUsernameButton(_ sender: Any) {
        if newUsernameTextField.isHidden{
            newUsernameTextField.isHidden = false
        }
        else{
            // Make sure the username isn't empty
            
            let parameters: [String: Any] = [
                "username": newUsernameTextField!.text!,
            ]
            /*
            AF.request("\(URLInfo.baseUrl)/users/\(LoggedInUser.username)/", method: .patch, parameters: parameters, headers: LoggedInUser.getHeaders()).responseDecodable(of: User.self) { response in
                switch response.result {
                    case .success:
                        self.newUsernameTextField.isHidden = true
                        self.changeUsernameInFriends(pasteName: response.value!.username)
                        self.changeUsernameInAllUsers(pasteName: response.value!.username)
                        LoggedInUser.username = response.value!.username
                        self.usernameLabel.text = LoggedInUser.username
                    case .failure:
                        self.statusLabel.isHidden = false
                        if (response.response != nil){
                            switch response.response!.statusCode{
                            case 400:
                                self.statusLabel.text = "Username already taken."
                            default:
                                self.statusLabel.text = "HTTP Error: \(response.response!.statusCode)"
                            }
                        }
                        else{
                            self.statusLabel.text = "No response."
                        }
                }
            }*/
        }
    }
    @IBAction func changePasswordButton(_ sender: Any) {
    }
    
    // When I change the username I gotta go through and change the user's username in all their friends
    func changeUsernameInFriends(pasteName: String){
        for friend in Friend.allFriends{
            if friend.teamCaptain.username == LoggedInUser.user.username{
                friend.teamCaptain.username = pasteName
            }
            else if friend.teammate.username == LoggedInUser.user.username{
                friend.teammate.username = pasteName
            }
        }
    }
    /*
    // Also I gotta change it in the list sent to us
    func changeUsernameInAllUsers(pasteName: String){
        for user in allUsers{
            if user.username == LoggedInUser.username{
                user.username = pasteName
            }
        }
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
