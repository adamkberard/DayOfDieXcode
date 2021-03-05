//
//  GameClasses.swift
//  DayOfDie
//
//  Created by Adam Berard on 3/4/21.
//

import UIKit

class Game {
    var timeStarted : Date
    var timeSaved : Date?
    var players : [Player]
    var names : [String]
    var teamScoreLabels : [UILabel]
    var chosenPlayer : Int
    var saveButton : UIBarButtonItem?
    
    init() {
        players = []
        teamScoreLabels = []
        timeStarted = Date()
        names = ["Adam", "Ben", "Jake", "Kyle", "Marcus"]
        self.chosenPlayer = 0
    }
    
    func getChosenPlayer() -> Player {
        return players[chosenPlayer]
    }
    
    func createPlayers(){
        for i in 0...3{
            let tempPlayer = Player(number: i, game: self)
            tempPlayer.labels.setPlayer(player: tempPlayer)
            players.append(tempPlayer)
        }
    }
    
    func setNames(names : [String]){
        self.names = names
    }
    
    func getNames() -> [String]{
        return names
    }
    
    func getNumNames() -> Int{
        return names.count
    }
    
    func getPlayerOne() -> Player {
        return players[0]
    }
    func getPlayerTwo() -> Player {
        return players[1]
    }
    func getPlayerThree() -> Player {
        return players[2]
    }
    func getPlayerFour() -> Player {
        return players[3]
    }
    
    func getMatchingNamePositions() -> [Int] {
        var matching : [Int] = []
        for i in (0...3){
            for j in (0...3){
                if(players[i].name == players[j].name && i != j){
                    matching.append(i)
                    matching.append(j)
                }
            }
        }
        
        return Array(Set(matching))
    }
    
    func namesAreValid() -> Bool{
        print("HERE")
        print(getMatchingNamePositions().count)
        return getMatchingNamePositions().count == 0
    }
    
    func colorCodeNames() {
        let matchingIndexes = getMatchingNamePositions()
        for i in (0...3){
            if(matchingIndexes.contains(i)){
                players[i].labels.pointsNameLabel.textColor = UIColor.red
                players[i].labels.tableLabel.textColor = UIColor.red
            }
            else{
                players[i].labels.pointsNameLabel.textColor = UIColor.black
                players[i].labels.tableLabel.textColor = UIColor.black
            }
        }
    }
    
    func getTeamOneScore() -> Int{
        return getPlayerOne().getTotalPoints() + getPlayerTwo().getTotalPoints()
    }
    
    func getTeamTwoScore() -> Int{
        return getPlayerThree().getTotalPoints() + getPlayerFour().getTotalPoints()
    }
    
    func updateTeamScoreLabels(){
        let teamOneScore = getTeamOneScore()
        let teamTwoScore = getTeamTwoScore()
        
        teamScoreLabels[0].text = String(teamOneScore)
        teamScoreLabels[1].text = String(teamTwoScore)
        
        
        // If neither team has at least 11 the game cannot be saved
        if([teamOneScore, teamTwoScore].max() ?? 0 < 11){
            return saveButton!.isEnabled = false
        }
        // If the winning team isn't up by at least 2 then it cannot be saved
        else if(abs(teamOneScore - teamTwoScore) < 2){
            return saveButton!.isEnabled = false
        }
        else{
            return saveButton!.isEnabled = true
        }
    }
    
    func updatePlayerScoreLabels(){
        for player in players{
            player.labels.updatePointLabels()
        }
    }
    
    func toDict() -> [String: Any] {
        var gameDict : [String: Any] = [:]
        var pointDicts : [[String: Any]] = []
        
        gameDict["timeStarted"] = timeStarted
        gameDict["playerOne"] = getPlayerOne().name
        gameDict["playerTwo"] = getPlayerTwo().name
        gameDict["playerThree"] = getPlayerThree().name
        gameDict["playerFour"] = getPlayerFour().name
        
        pointDicts.append(contentsOf: getPlayerOne().getPointDicts())
        pointDicts.append(contentsOf: getPlayerTwo().getPointDicts())
        pointDicts.append(contentsOf: getPlayerThree().getPointDicts())
        pointDicts.append(contentsOf: getPlayerFour().getPointDicts())
        gameDict["points"] = pointDicts
        
        return gameDict
    }
}

class Player {
    var playerNumber : Int
    var name : String
    var points : Int
    var tinks : [String]
    var sinks : [String]
    var bounceSinks : [String]
    var partnerSinks : [String]
    var selfSinks : Int
    var labels : PlayerLabels
    var game : Game
    
    init(number: Int, game: Game) {
        self.playerNumber = number
        self.name = game.names[number]
        self.points = 0
        self.tinks = []
        self.sinks = []
        self.bounceSinks = []
        self.partnerSinks = []
        self.selfSinks = 0
        self.game = game
        self.labels = PlayerLabels()
    }
    
    func isTeamOne() -> Bool{
        return playerNumber == 0 || playerNumber == 1
    }
    
    func isTeamTwo() -> Bool{
        return playerNumber == 2 || playerNumber == 3
    }
    
    func getPlayerOponents() -> [String] {
        if(isTeamOne()){
            return [game.getPlayerThree().name, game.getPlayerFour().name]
        }
        else{
            return [game.getPlayerOne().name, game.getPlayerTwo().name]
        }
    }
    
    func getPartner() -> Player {
        switch playerNumber {
        case 0:
            return game.getPlayerTwo()
        case 1:
            return game.getPlayerOne()
        case 2:
            return game.getPlayerFour()
        case 3:
            return game.getPlayerThree()
        default:
            return game.getPlayerTwo()
        }
    }
    
    func setPrevName(){
        let inIndex = game.getNames().firstIndex(of: name) ?? 0
        if inIndex == (game.getNumNames() - 1){
            name = game.getNames()[0]
        }
        else{
            name = game.getNames()[inIndex + 1]
        }
        labels.updateNameLabels()
    }
    func setNextName(){
        let inIndex = game.getNames().firstIndex(of: name) ?? 0
        if inIndex == 0{
            name = game.getNames()[game.getNumNames() - 1]
        }
        else{
            name = game.getNames()[inIndex - 1]
        }
        labels.updateNameLabels()
    }
    
    func subtractPoint(){
        if(points > 0){
            points -= 1
        }
        else{
            points = 0
        }
        labels.updatePointLabels()
        game.updateTeamScoreLabels()
    }
    
    func addPoint(){
        points += 1
        labels.updatePointLabels()
        game.updateTeamScoreLabels()
    }
    
    func getTotalPoints() -> Int {
        var totalPoints = 0
        totalPoints += points
        totalPoints += (tinks.count * 2)
        totalPoints += (bounceSinks.count * 2)
        totalPoints += (sinks.count * 3)
        return totalPoints
    }
    
    func getPointDicts() -> [[String: Any]]{
        var pointsList : [[String: Any]] = []
        
        for _ in 0..<points {
            pointsList.append(["typeOfPoint": "PT",
                               "scorer": name,
                               "scoredOn": ""])
        }
        for name in tinks {
            pointsList.append(["typeOfPoint": "TK",
                               "scorer": name,
                               "scoredOn": name])
        }
        for name in sinks {
            pointsList.append(["typeOfPoint": "SK",
                           "scorer": name,
                           "scoredOn": name])
        }
        for name in bounceSinks {
            pointsList.append(["typeOfPoint": "BS",
                               "scorer": name,
                               "scoredOn": name])
        }
        for name in partnerSinks {
            pointsList.append(["typeOfPoint": "PS",
                               "scorer": name,
                               "scoredOn": name])
        }
        for _ in 0..<selfSinks {
            pointsList.append(["typeOfPoint": "SS",
                               "scorer": name,
                               "scoredOn": ""])
        }
        return pointsList
    }
}

class PlayerLabels {
    // This might be really stupid, but I have to init all these vars,
    // and I don't want to have to like make it optional cuz that's a pain
    // so I'm just gonna have a dummy UILabel I assign them all to
    let dummyUILabel : UILabel
    var tableLabel: UILabel
    var pointsNameLabel: UILabel
    var bigPointsLabel: UILabel
    var pointsLabel: UILabel
    var tinksLabel: UILabel
    var sinksLabel: UILabel
    var bounceSinksLabel: UILabel
    var partnerSinksLabel: UILabel
    var selfSinksLabel: UILabel
    var player : Player?
    
    init() {
        dummyUILabel = UILabel()
        tableLabel = dummyUILabel
        pointsLabel = dummyUILabel
        pointsNameLabel = dummyUILabel
        bigPointsLabel = dummyUILabel
        pointsLabel = dummyUILabel
        tinksLabel = dummyUILabel
        sinksLabel = dummyUILabel
        bounceSinksLabel = dummyUILabel
        partnerSinksLabel = dummyUILabel
        selfSinksLabel = dummyUILabel
    }
    
    func setPlayer(player: Player){
        self.player = player
    }
    
    func updateNameLabels() {
        tableLabel.text = player!.name
        pointsNameLabel.text = player!.name
        player!.game.colorCodeNames()
    }
    
    func updatePointLabels() {
        bigPointsLabel.text = String(player!.points)
        pointsLabel.text = String(player!.points)
        tinksLabel.text = String(player!.tinks.count)
        sinksLabel.text = String(player!.sinks.count)
        bounceSinksLabel.text = String(player!.bounceSinks.count)
        partnerSinksLabel.text = String(player!.partnerSinks.count)
        selfSinksLabel.text = String(player!.selfSinks)
    }
}
