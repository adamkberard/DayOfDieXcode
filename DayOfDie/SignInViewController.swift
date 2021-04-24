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
        
        AF.request("\(URLInfo.baseUrl)/auth/login/", method: .post, parameters: parameters).responseDecodable(of: LoginPack.self) { response in
            switch response.result {
                case .success:
                    currentUser = response.value!.user
                    userGames = response.value!.games
                    print(userGames)
                    userFriends = response.value!.friends
                    self.performSegue(withIdentifier: "signInSegue", sender: self)
                case let .failure(error):
                    print(error)
            }
        }
        
        /*
        let url = "\(URLInfo.baseUrl)/auth/login/"
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
                    CurrentUser.token = token
                    CurrentUser.username = username
                    
                    // Save the token to keychain
                    let key = token
                    let tag = "com.dayofdie.keys.mytoken".data(using: .utf8)!
                    let addquery: [String: Any] = [kSecClass as String: kSecClassKey,
                                                   kSecAttrApplicationTag as String: tag,
                                                   kSecValueRef as String: key]
                    
                    SecItemAdd(addquery as CFDictionary, nil)
                    
                    self.performSegue(withIdentifier: "signInSegue", sender: self)
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
        statusLabel.text = "Loading..." */
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            print("The identifier is: \(identifier)")
            if identifier == "signInSegue" {
                guard let viewController = segue.destination as? UserTabViewController else {
                 fatalError("Unexpected destination: \(segue.destination)")}
                viewController.user = user
            }
        }
    }
    */
}
