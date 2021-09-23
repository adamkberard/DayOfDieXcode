//
//  BaseTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/22/21.
//

import UIKit

class BaseTableViewCell<T: Decodable>: UITableViewCell {
    func setupCell(object: T){
        fatalError("Subclasses need to implement the `setupCell()` method.")
    }
}
