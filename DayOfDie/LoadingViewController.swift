//
//  LoadingViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 8/30/21.
//

import UIKit
import Alamofire


class LoadingViewController: UIViewController {
    
    var successUsersLoad : Bool = false
    var successGamesLoad : Bool = false
    var successFriendsLoad : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading friends here
        APICalls.getFriends {status, returnDict in
            if status{
                Friend.allFriends = returnDict["object"] as! [Friend]
                self.successFriendsLoad = true
                if self.isAllDataLoaded(){
                    self.performSegue(withIdentifier: "toMainApp", sender: self)
                }
            }
            else{
                //Handle if things go wrong
                print(returnDict["errors"]!)
            }
        }
        
        // Loading all users here
        APICalls.getUsers {status, returnDict in
            if status{
                // Check if everything is done if so move on
                User.allUsers = returnDict["object"] as! [User]
                self.successUsersLoad = true
                if self.isAllDataLoaded(){
                    self.performSegue(withIdentifier: "toMainApp", sender: self)
                }
            }
            else{
                //Handle if things go wrong
                print(returnDict["errors"]!)
            }
        }
        
        // Loading all games here
        APICalls.getGames {status, returnDict in
            if status{
                // Check if everything is done if so move on
                Game.allGames = returnDict["object"] as! [Game]
                self.successGamesLoad = true
                if self.isAllDataLoaded(){
                    self.performSegue(withIdentifier: "toMainApp", sender: self)
                }
            }
            else{
                //Handle if things go wrong
                print(returnDict["errors"]!)
            }
            
        }
    }
    
    func isAllDataLoaded() -> Bool {
        return successUsersLoad && successGamesLoad && successFriendsLoad
    }
}

class APICalls {
    
    static func login(email: String, password: String, completion: @escaping (Bool, [String: Any]) -> Void) {
        let url = "\(URLInfo.baseUrl)/auth/login/"
        performLogin(email: email, password: password, url: url) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func register(email: String, password: String, completion: @escaping (Bool, [String: Any]) -> Void) {
        let url = "\(URLInfo.baseUrl)/auth/register/"
        performLogin(email: email, password: password, url: url) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func getFriends(completion: @escaping (Bool, [String: Any]) -> Void) {
        get(url: "\(URLInfo.baseUrl)/friends/", inType: [Friend].self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func getUsers(completion: @escaping (Bool, [String: Any]) -> Void) {
        get(url: "\(URLInfo.baseUrl)/users/", inType: [User].self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func getGames(completion: @escaping (Bool, [String: Any]) -> Void) {
        get(url: "\(URLInfo.baseUrl)/games/", inType: [Game].self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func sendGame(parameters: [String: Any], completion: @escaping (Bool, [String: Any]) -> Void) {
        print("params: \(parameters)")
        post(url: "\(URLInfo.baseUrl)/games/", parameters: parameters, returnType: Game.self) { status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func performLogin(email: String, password: String, url: String, completion: @escaping (Bool, [String: Any]) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]

        AF.request(url, method: .post, parameters: parameters).responseJSON { response in
            var eDict : [String: [String]] = [:]
            guard let returnStatusCode = response.response?.statusCode else {
                eDict["errors"] = ["No connection."]
                completion(false, eDict)
                return
            }
            switch returnStatusCode {
            case 200, 201:
                let returnDict:[String:String] = response.value as! [String : String]
                completion(true, returnDict)
            case 400:
                let errorsDict : [String:[String]] = response.value as! [String : [String]]
                eDict["errors"] = []
                if errorsDict.index(forKey: "email") != nil {
                    eDict["errors"]!.append(contentsOf: errorsDict["email"]!)
                }
                if errorsDict.index(forKey: "password") != nil {
                    eDict["errors"]!.append(contentsOf: errorsDict["email"]!)
                }
                completion(false, eDict)
            default:
                eDict["errors"] = ["Error."]
                completion(false, eDict)
            }
        }
    }
    
    static func get<T: Decodable>(url: String, inType: T.Type, completion: @escaping (Bool, [String: Any]) -> Void) {
        AF.request(url, method: .get, headers: getHeaders(), encoder: JSONEncoder).responseDecodable(of: inType.self) { response in
            var eDict : [String: [String]] = [:]
            guard let returnStatusCode = response.response?.statusCode else {
                eDict["errors"] = ["No connection."]
                completion(false, eDict)
                return
            }
            switch returnStatusCode {
            case 200:
                print(response.error)
                let returnDict : [String: Any] = ["object" : response.value!]
                completion(true, returnDict)
            case 400:
                let errorsDict : [String:[String]] = response.value as! [String : [String]]
                eDict = getErrorsFromParams(params: [:], errorsDict: errorsDict)
                completion(false, eDict)
            default:
                eDict["errors"] = ["Error."]
                completion(false, eDict)
            }
        }
    }
    
    static func post<T: Decodable>(url: String, parameters: [String: Any], returnType: T.Type, completion: @escaping (Bool, [String: Any]) -> Void) {
        AF.request(url, method: .post, headers: getHeaders()).responseDecodable(of: returnType.self) { response in
            var eDict : [String: [String]] = [:]
            guard let returnStatusCode = response.response?.statusCode else {
                eDict["errors"] = ["No connection."]
                completion(false, eDict)
                return
            }
            switch returnStatusCode {
            case 201:
                let returnDict : [String: Any] = ["object" : response.value!]
                completion(true, returnDict)
            case 400:
                print("HERE3")
                let errorsDict : [String:[String]] = [:]
                eDict = getErrorsFromParams(params: parameters, errorsDict: errorsDict)
                print(response.error)
                completion(false, eDict)
            default:
                eDict["errors"] = ["Error."]
                completion(false, eDict)
            }
        }
    }
    
    static func getErrorsFromParams(params: [String: Any], errorsDict: [String: [String]]) -> [String: [String]]{
        var eDict : [String: [String]] = [:]
        eDict["errors"] = []
        
        if errorsDict.index(forKey: "non_field_errors") != nil {
            eDict["errors"]!.append(contentsOf: errorsDict["non_field_errors"]!)
        }
        
        for key in errorsDict.keys{
            eDict["errors"]!.append(contentsOf: errorsDict[key]!)
        }
        return eDict
    }
    
    static func getHeaders()->HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Token \(LoggedInUser.token)",
        ]
        return headers
    }

}

class LoggedInUser : Codable{
    static var token : String = ""
    static var email : String = ""
    static var user : User = User()
}
