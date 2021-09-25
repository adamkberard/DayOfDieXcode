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
    static var baseUrl = "http://127.0.0.1:8000"
    //static var baseUrl = "https://dayofdie.herokuapp.com"
}


class LoadingViewController: UIViewController {
    
    var successPlayersLoad : Bool = false
    var successGamesLoad : Bool = false
    var successTeamsLoad : Bool = false
    var successUserLoad : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading friends here
        APICalls.getTeams {status, returnData in
            if status{
                Team.allTeams = returnData as! [Team]
                self.successTeamsLoad = true
                if self.isAllDataLoaded(){
                    self.performSegue(withIdentifier: "toMainApp", sender: self)
                }
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
                // Alert Stuff
                let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
        
        // Loading all users here
        APICalls.getUsers {status, returnData in
            if status{
                // Check if everything is done if so move on
                Player.allPlayers = returnData as! [Player]
                self.successPlayersLoad = true
                if self.isAllDataLoaded(){
                    self.performSegue(withIdentifier: "toMainApp", sender: self)
                }
            }
            else{
                let errors : [String] = returnData as! [String]
                print(errors)
                // Alert Stuff
                let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                self.present(alert, animated: true)
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
                let errors : [String] = returnData as! [String]
                print(errors)
                // Alert Stuff
                let alert = UIAlertController(title: "Connection Error", message: errors.first, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cool", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    func isAllDataLoaded() -> Bool {
        return successPlayersLoad && successGamesLoad && successTeamsLoad
    }
}

class APICalls {
    
    // MARK: Auth
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
    
    // MARK: Getters
    static func getPlayerGames(player: Player, completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/games/\(player.username)/", returnType: [Game].self) { status, returnData in
            completion(status, returnData)
        }
    }
    
    static func getPlayerTeams(player: Player, completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/teams/\(player.username)/", returnType: [Team].self) { status, returnData in
            completion(status, returnData)
        }
    }
    
    static func getTeamGames(team: Team, completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/games/\(team.teamCaptain.username)/\(team.teammate.username)/", returnType: [Game].self) { status, returnData in
            completion(status, returnData)
        }
    }
    
    static func getUser(username: String, completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/users/\(username)/", returnType: Player.self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func getTeams(completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/teams/", returnType: [Team].self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func getUsers(completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/players/", returnType: [Player].self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    static func getGames(completion: @escaping (Bool, Any) -> Void) {
        get(url: "\(URLInfo.baseUrl)/games/", returnType: [Game].self) {status, returnDict in
            completion(status, returnDict)
        }
    }
    
    // MARK: Creates
    static func sendGame(parameters: [String: Any], completion: @escaping (Bool, Any) -> Void) {
        post(url: "\(URLInfo.baseUrl)/games/", parameters: parameters, returnType: Game.self) { status, returnData in
            completion(status, returnData)
        }
    }
    
    static func sendFriend(parameters: [String: Any], completion: @escaping (Bool, Any) -> Void) {
        post(url: "\(URLInfo.baseUrl)/teams/", parameters: parameters, returnType: Team.self) { status, returnData in
            completion(status, returnData)
        }
    }
    
    // MARK: Editors
    static func changeUsername(parameters: [String: Any], completion: @escaping (Bool, Any) -> Void) {
        patch(url: "\(URLInfo.baseUrl)/players/\(User.player.username)/", parameters: parameters, returnType: Player.self) { status, returnData in
            completion(status, returnData)
        }
    }
    
    
    // MARK: Basic Requests
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
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getHeaders()).responseDecodable(of: returnType.self) { response in
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
    
    static func patch<T: Decodable>(url: String, parameters: [String: Any], returnType: T.Type, completion: @escaping (Bool, Any) -> Void) {
        AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: getHeaders()).responseDecodable(of: returnType.self) { response in
            guard let returnStatusCode = response.response?.statusCode else {
                print(response)
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
            for error in errorsDict[key]!{
                errors.append("\(key) - \(error)")
            }
        }
        // If we don't get any param errors it's nice to return that. Saves me debug time
        if errors.isEmpty{
            errors.append("No param errors.")
        }
        return errors
    }
    
    static func getHeaders()->HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Token \(User.token)",
        ]
        return headers
    }

}
