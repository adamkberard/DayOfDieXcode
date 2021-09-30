//
//  StatSearchViewController.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/29/21.
//

import UIKit

class StatSearchViewController: SearchTableViewController<Stat> {
    
    override func setRawObjectList() -> [Stat] { return StatSet.getStats() }
    override func setObjectList(rawList: [Stat]) -> [Stat] { return rawList }
    override func setCellIdentifiers() -> [String] { return ["StatCell"] }
    override func setTableSegueIdentifier() -> String { return "toStatDetail" }
    override func setFetchURLEnding() -> String { return "" }
    override func setRefreshTitleString() -> String { return "" }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toStatDetail" {
                guard let viewController = segue.destination as? StatDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")}
                viewController.stat = selectedObject
            }
        }
    }
    
    override func fetchObjectData() {}
}
