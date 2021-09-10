//
//  PlayerScorePicker.swift
//
//
//  Created by Adam Berard on 4/21/21.
//

import UIKit

@IBDesignable
class PlayerPointsPlayerScorePicker: UIView {

    // Mark: UI Vars
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var points : Int = 0 {
        didSet{
            pointsLabel.text = String(points)
        }
    }
    
    var mainTrackingViewController : MainTrackingViewController?
    var playerNumber : Int = 0
    
    var player : User? {
        didSet { playerLabel.text = player!.username }
    }
    
    // Mark: View Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    func commonSetup() {
        let view = viewFromNibForClass()
        view.frame = bounds
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        // Show the view.
        addSubview(view)
        
        playerLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2 * 3)
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return view
    }
    
}
