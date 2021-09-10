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

        APICalls.register(email: email, password: password) {status, returnDict in
            if status{
                LoggedInUser.token = returnDict["token"] as! String
                LoggedInUser.user.username = returnDict["username"] as! String
                LoggedInUser.email = email
                self.performSegue(withIdentifier: "registerSegue", sender: self)
            }
            else{
                self.statusLabel.textColor = UIColor.red
                self.statusLabel.isHidden = false
                let errors : [String] = returnDict["errors"] as! [String]
                var errorString : String = ""
                for error in errors{
                    errorString.append("\(error)\n")
                }
                self.statusLabel.text = errorString
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
