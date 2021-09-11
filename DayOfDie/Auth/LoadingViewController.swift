//
//  LoadingViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 8/30/21.
//

import UIKit
import Alamofire


struct URLInfo{
    //static var baseUrl = "https://dayofdie-test.herokuapp.com"
    //static var baseUrl = "https://dayofdie.herokuapp.com"
    //static var baseUrl = "http://localhost:8000"
    static var baseUrl = "http://127.0.0.1:8000"
}


class LoadingViewController: UIViewController {
    
    var successUsersLoad : Bool = false
    var successGamesLoad : Bool = false
    var successFriendsLoad : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading friends here
        APICalls.getFriends {status, returnData in
            if status{
                Friend.allFriends = returnData as! [Friend]
                self.successFriendsLoad = true
                if self.isAllDataLoaded(){
                    self.performSegue(withIdentifier: "toMainApp", sender: self)
                }
            }
            else{
                //Handle if things go wrong
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
        
        // Loading all users here
        APICalls.getUsers {status, returnData in
            if status{
                // Check if everything is done if so move on
                User.allUsers = returnData as! [User]
                self.successUsersLoad = true
                if self.isAllDataLoaded(){
                    self.performSegue(withIdentifier: "toMainApp", sender: self)
                }
            }
            else{
                //Handle if things go wrong
                let errors : [String] = returnData as! [String]
                print(errors)
            }
        }
        
        // Loading all games here
        APICalls.getGames {status, returnData in
            if status{
                // Check if everything is done if so move on
                Game.allGames = returnData as! [Game]
                self.successGamesLoad = true
                if self.isAllDataLoaded(){
                    self.performSegue(withIdentifier: "toMainApp", sender: self)
                }
            }
            else{
                //Handle if things go wrong
                let errors : [String] = returnData as! [String]
                print(errors)
            }
            
        }
    }
    
    func isAllDataLoaded() -> Bool {
        return successUsersLoad && successGamesLoad && successFriendsLoad
    }
}

class APICalls {
    
    static func login(parameters: [String: Any], completion: @escaping (Bool, Any) -> Void) {
        let url = "\(URLInfo.baseUrl)/auth/login/"
        post(url: url, parameters: parameters, returnType: LoginPack.self) {status, returnData in
            completion(status, returnData)
        }
    }
    
    static func register(parameters: [String: Any], completion: @escaping (Bool, Any) -> Void) {
        let url = "\(URLInfo.baseUrl)/auth/register/"
        post(url: url, parameters: parameters, returnType: LoginPack.self) {status, returnData in
            completion(status, returnData)
        }
    }
    
    static func getFriends(completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/friends/", returnType: [Friend].self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func getUsers(completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/users/", returnType: [User].self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func getGames(completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/games/", returnType: [Game].self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func sendGame(parameters: [String: Any], completion: @escaping (Bool, Any) -> Void) {
        print("params: \(parameters)")
        post(url: "\(URLInfo.baseUrl)/games/", parameters: parameters, returnType: Game.self) { status, returnData in
            completion(status, returnData)
        }
    }
    
    static func sendFriend(parameters: [String: Any], completion: @escaping (Bool, Any) -> Void) {
        print("params: \(parameters)")
        post(url: "\(URLInfo.baseUrl)/friends/", parameters: parameters, returnType: Friend.self) { status, returnData in
            completion(status, returnData)
        }
    }
    
    static func get<T: Decodable>(url: String, returnType: T.Type, completion: @escaping (Bool, Any) -> Void) {
        AF.request(url, method: .get, headers: getHeaders()).responseDecodable(of: returnType.self) { response in
            guard let returnStatusCode = response.response?.statusCode else {
                let errors : [String] = ["No connection."]
                completion(false, errors)
                return
            }
            switch returnStatusCode {
            case 200, 201:
                let returnData = response.value!
                completion(true, returnData)
            case 400:
                var errorsDict : [String: [String]] = [:]
                do {
                    errorsDict = try JSONDecoder().decode(Dictionary<String, [String]>.self, from: response.data!)
                } catch {
                    errorsDict["my_side_errors"] = ["Couldn't decode json response."]
                }
                let errors : [String] = getErrorsFromParams(params: [:], errorsDict: errorsDict)
                completion(false, errors)
            default:
                let errors : [String] = ["Error."]
                completion(false, errors)
            }
        }
    }
    
    static func post<T: Decodable>(url: String, parameters: [String: Any], returnType: T.Type, completion: @escaping (Bool, Any) -> Void) {
        
        AF.request(url, method: .post, parameters: parameters, headers: getHeaders()).responseDecodable(of: returnType.self) { response in
            guard let returnStatusCode = response.response?.statusCode else {
                let returnData : [String] = ["No connection."]
                completion(false, returnData)
                return
            }
            switch returnStatusCode {
            case 200, 201:
                let returnData = response.value!
                completion(true, returnData)
            case 400:
                var errorsDict : [String: [String]] = [:]
                do {
                    errorsDict = try JSONDecoder().decode(Dictionary<String, [String]>.self, from: response.data!)
                } catch {
                    errorsDict["my_side_errors"] = ["Couldn't decode json response."]
                }
                let errors : [String] = getErrorsFromParams(params: parameters, errorsDict: errorsDict)
                completion(false, errors)
            default:
                let errors : [String] = ["Error."]
                completion(false, errors)
            }
        }
    }
    
    static func getErrorsFromParams(params: [String: Any], errorsDict: [String: [String]]) -> [String]{
        var errors : [String] = []
        
        if errorsDict.index(forKey: "non_field_errors") != nil {
            errors.append(contentsOf: errorsDict["non_field_errors"]!)
        }
        
        if errorsDict.index(forKey: "my_side_errors") != nil {
            errors.append(contentsOf: errorsDict["my_side_errors"]!)
        }
        
        for key in errorsDict.keys{
            errors.append(contentsOf: errorsDict[key]!)
        }
        if errors.isEmpty{
            errors.append("No param errors.")
        }
        return errors
    }
    
    static func getHeaders()->HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Token \(ThisUser.token)",
        ]
        return headers
    }

}
