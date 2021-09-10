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
        let url = "/auth/login/"
        APICalls.post(url: url, parameters: parameters, returnType: LoginPack.self) { status, returnDict in
            if status{
                // Check if everything is done if so move on
                let loginPack = returnDict["object"] as! LoginPack
                ThisUser.user.username = loginPack.username
                ThisUser.token = loginPack.token
                ThisUser.email = email
            }
            else{
                //Handle if things go wrong
                print(returnDict["errors"]!)
            }
        }
    }
}

class LoginPack: Decodable {
    var username : String = ""
    var token : String = ""
}
