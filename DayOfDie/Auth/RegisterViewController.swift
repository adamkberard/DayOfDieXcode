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
        
        AF.request("\(URLInfo.baseUrl)/auth/register/", method: .post, parameters: parameters).responseDecodable(of: LoginPack.self) { response in
            switch response.result {
                case .success:
                    CurrentUser.username = response.value!.user.username
                    CurrentUser.uuid = response.value!.user.uuid
                    CurrentUser.email = response.value!.user.email
                    CurrentUser.token = response.value!.user.token
                    
                    CurrentUser.games = response.value!.games
                    CurrentUser.friends = response.value!.friends

                    allUsers = response.value!.all_users
                    self.performSegue(withIdentifier: "registerSegue", sender: self)
                case .failure:
                    self.statusLabel.isHidden = false
                    if (response.response != nil){
                        switch response.response!.statusCode{
                        case 400:
                            self.statusLabel.text = "Email or password invalid."
                        case 500:
                            self.statusLabel.text = "Email already used."
                        default:
                            self.statusLabel.text = "HTTP Error: \(response.response!.statusCode)"
                        }
                    }
                    else{
                        self.statusLabel.text = "No response."
                    }
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
