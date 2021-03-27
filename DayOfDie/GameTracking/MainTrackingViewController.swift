//
//  ViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/2/21.
//

import UIKit
import Alamofire

class MainTrackingViewController: UIViewController {
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.items?.last?.rightBarButtonItem?.isEnabled = false
        
        // Activity Indicator stuff
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // Player Switching
    @IBAction func playerOneSwitchLeft(_ sender: Any) {
        
    }
    @IBAction func playerOneSwitchRight(_ sender: Any) {
        
    }
    @IBAction func playerTwoSwitchLeft(_ sender: Any) {
        
    }
    @IBAction func playerTwoSwitchRight(_ sender: Any) {
        
    }
    @IBAction func playerThreeSwitchLeft(_ sender: Any) {
        
    }
    @IBAction func playerThreeSwitchRight(_ sender: Any) {
        
    }
    @IBAction func playerFourSwitchLeft(_ sender: Any) {
        
    }
    @IBAction func playerFourSwitchRight(_ sender: Any) {
        
    }
    
    // Point adding & subtracting
    @IBAction func playerOnePointsMinus(_ sender: Any) {
        
    }
    @IBAction func playerOnePointsPlus(_ sender: Any) {
        
    }
    @IBAction func playerTwoPointsMinus(_ sender: Any) {
        
    }
    @IBAction func playerTwoPointsPlus(_ sender: Any) {
        
    }
    @IBAction func playerThreePointsMinus(_ sender: Any) {
        
    }
    @IBAction func playerThreePointsPlus(_ sender: Any) {
        
    }
    @IBAction func playerFourPointsMinus(_ sender: Any) {
        
    }
    @IBAction func playerFourPointsPlus(_ sender: Any) {
        
    }
    
    // Special Points Buttons
    @IBAction func playerOneSpecialPointButtonPressed(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    @IBAction func playerTwoSpecialPointButtonPressed(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    @IBAction func playerThreeSpecialPointButtonPressed(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    @IBAction func playerFourSpecialPointButtonPressed(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "toSpecialPointsTable", sender: self)
    }
    
    @IBAction func saveGameButtonPressed(_ sender: Any) {
        // Now it sends the data to me
        // Prepare json data
        /*let gameDict : [String: Any] = game.toDict()
        
        let parameters : [String: Any] = [
            "game": gameDict
        ]
        let url = "\(URLInfo.baseUrl)/game/"
        AF.request(url, method: .post, parameters: parameters, encoding:JSONEncoding.default).responseJSON { response in
            // Turn off activity indicator
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            if let statusCode = response.response?.statusCode {
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
                if((200...299).contains(statusCode)){
                    // Eventually I will need to wipe the screen clear to let them know it's been saved
                    // Maybe even send them to the games screen. Will do that rn
                }
                else{
                    print("IDK WHAT HAPPENED \(response.response!.statusCode)")
                    debugPrint(response)
                }
            }
            else{
                print("no connection")
            }
        }
        
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false*/
    }
    
    // Other functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "toSpecialPointsTable" {
                guard let viewController = segue.destination as? SpecialPointsViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                //viewController.PrevViewController = self
                //viewController.chosenPlayerNumber = game.chosenPlayer
                //viewController.player = game.getChosenPlayer()
            }
        }
    }
}

