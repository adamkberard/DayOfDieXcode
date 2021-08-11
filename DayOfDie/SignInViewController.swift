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
        
        AF.request("\(URLInfo.baseUrl)/auth/login/", method: .post, parameters: parameters).responseDecodable(of: LoginPack.self) { response in
            switch response.result {
                case .success:
                    CurrentUser.username = response.value!.user.username
                    CurrentUser.uuid = response.value!.user.uuid
                    CurrentUser.email = response.value!.user.email
                    CurrentUser.token = response.value!.user.token
                    
                    CurrentUser.games = response.value!.games
                    CurrentUser.friends = response.value!.friends

                    allUsers = response.value!.all_users
                    self.performSegue(withIdentifier: "signInSegue", sender: self)
                case .failure:
                    self.statusLabel.isHidden = false
                    if (response.response != nil){
                        switch response.response!.statusCode{
                        case 400:
                            self.statusLabel.text = "Incorrect credentials."
                        default:
                            self.statusLabel.text = "HTTP Error: \(response.response!.statusCode)"
                        }
                    }
                    else{
                        self.statusLabel.text = "No response."
                    }
            }
        }
    }
}
