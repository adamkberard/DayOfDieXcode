//
//  TableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 8/12/21.
//

import UIKit

class StatTableViewCell: UITableViewCell {

    @IBOutlet weak var statNameLabel: UILabel!
    @IBOutlet weak var statNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
