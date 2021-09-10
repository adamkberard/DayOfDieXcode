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

        APICalls.login(email: email, password: password) {status, returnDict in
            if status{
                LoggedInUser.token = returnDict["token"] as! String
                LoggedInUser.user.username = returnDict["username"] as! String
                LoggedInUser.email = email
                self.performSegue(withIdentifier: "signInSegue", sender: self)
            }
            else{
                self.statusLabel.textColor = UIColor.red
                self.statusLabel.isHidden = false
                self.statusLabel.text = returnDict["error"] as? String
            }
        }
    }
}
