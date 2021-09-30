//
//  SingInPageViewController.swift
//  cleanerLife
//
//  Created by Adam Berard on 12/26/20.
//

import UIKit
import Alamofire

class SignInViewController:
    UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func SignInButtonPressed(_ sender: Any) {
        // Now it sends the data to me
        // Prepare json data
        
        let email : String = emailTextField.text ?? ""
        let password : String = passwordTextField.text ?? ""

        statusLabel.textColor = UIColor.red

        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        APICalls.login(parameters: parameters) { status, returnData in
            if status{
                // Check if everything is done if so move on
                let loginPack = returnData as! LoginPack
                User.token = loginPack.token
                User.player = PlayerSet.getPlayer(inPlayer: loginPack.player!)
                self.performSegue(withIdentifier: "signInSegue", sender: self)
            }
            else{
                //Handle if things go wrong
                let errors : [String] = returnData as! [String]
                self.statusLabel.text = errors[0]
                self.statusLabel.isHidden = false
            }
        }
    }
}

class LoginPack: Decodable {
    var token : String = ""
    var player : Player?
}
