//
//  RegisterViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 2/3/21.
//

import UIKit
import Alamofire

class RegisterViewController:
    UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordOneTextField: UITextField!
    @IBOutlet weak var passwordTwoTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        // Now it sends the data to me
        // Prepare json data
        let email : String = emailTextField.text ?? ""
        let password : String = passwordOneTextField.text ?? ""
        
        // If we're in here the label will be unhidden,
        // and more than likely will be red
        statusLabel.textColor = UIColor.red
        
        var tempError : String = validateEmail(email: email)
        if(tempError != "valid"){
            statusLabel.text = tempError
            return
        }
        
        tempError = validatePassword(password: password)
        if(tempError != "valid"){
            statusLabel.textColor = UIColor.red
            statusLabel.text = tempError
            return
        }
        
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false

        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        APICalls.register(parameters: parameters) { status, returnData in
            if status{
                // Check if everything is done if so move on
                let loginPack = returnData as! LoginPack
                User.token = loginPack.token
                User.player = PlayerSet.getPlayer(inPlayer: loginPack.player!)
                self.performSegue(withIdentifier: "registerSegue", sender: self)
            }
            else{
                //Handle if things go wrong
                let errors : [String] = returnData as! [String]
                self.statusLabel.text = errors[0]
                self.statusLabel.isHidden = false
            }
        }
        view.isUserInteractionEnabled = true
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
