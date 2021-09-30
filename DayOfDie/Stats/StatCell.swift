//
//  StatCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/29/21.
//

import UIKit

class StatCell: BaseTableViewCell<Stat> {

    @IBOutlet weak var statNameLabel: UILabel!
    
    var stat : Stat?
    
    override func setupCell(object: Stat) {
        stat = object
        
        statNameLabel.text = stat!.name
    }
}
