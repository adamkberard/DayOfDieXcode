//
//  RegisterViewController.swift
//  cleanerLife
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.hideKeyboardWhenTappedAround() 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //emailTextBox.delegate = self
        //passwordTextBox.delegate = self
        //secondPasswordTextBox.delegate = self
        // Do any additional setup after loading the view.
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
        self.statusLabel.isHidden = false
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

        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        let url = "\(URLInfo.baseUrl)/auth/register/"
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            if let statusCode = response.response?.statusCode {
                if((200...299).contains(statusCode)){
                    guard let JSON = response.value as? NSDictionary else {
                        self.statusLabel.text = "Cannot convert JSON to dictionary."
                        return
                    }
                    guard let token = JSON["token"] as? String else {
                        self.statusLabel.text = "Cannot find a response token in dictionary."
                        return
                    }
                    guard let username = JSON["username"] as? String else {
                        self.statusLabel.text = "Cannot find a username in dictionary."
                        return
                    }
                    currentUser.token = token
                    currentUser.username = username
                    
                    self.performSegue(withIdentifier: "registerSegue", sender: self)
                }
                else{
                    if(response.response!.statusCode == 401){
                        self.statusLabel.text = "Incorrect email or password."
                    }
                    else{
                        self.statusLabel.text = "Http Status Code: \(response.response!.statusCode)"
                    }
                    debugPrint(response)
                }
            }
            else{
                self.statusLabel.text = "No connection."
            }
        }
        statusLabel.text = "Loading..."
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
