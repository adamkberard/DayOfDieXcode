//
//  PointTableViewCell.swift
//  DayOfDie
//
//  Created by Adam Berard on 9/22/21.
//

import UIKit

class PointCell: BaseTableViewCell<Point> {
    
    @IBOutlet weak var pointLabel: UILabel!
    
    var point : Point!
    
    override func setupCell(object: Point){
        self.point = object
        pointLabel.text = point.getString()
    }
}
