//
//  PlayerScorePicker.swift
//  
//
//  Created by Adam Berard on 4/21/21.
//

import UIKit

@IBDesignable
class PlayerScorePicker: UIView {

    // Mark: UI Vars
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var regularPointButton: UIButton!
    @IBOutlet weak var tinkButton: UIButton!
    @IBOutlet weak var sinkButton: UIButton!
    @IBOutlet weak var bounceSinkButton: UIButton!
    @IBOutlet weak var partnerSinkButton: UIButton!
    @IBOutlet weak var selfSinkButton: UIButton!
    @IBOutlet weak var fifaButton: UIButton!
    @IBOutlet weak var fieldGoalButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var regularPoints : Int = 1
    var tinkPoints : Int = 2
    var sinkPoints : Int = 3
    var bounceSinkPoints : Int = 2
    var partnerSinkPoints : Int = 0
    var selfSinkPoints : Int = 0
    var fifaPoints : Int = 0
    var fieldGoalPoints : Int = 0
    var fivePoints : Int = 0
    
    var mainTrackingViewController : MainTrackingViewController?
    var playerNumber : Int = 0
    
    // Mark: My Vars
    var primaryButtons : [UIButton] = []
    var player : BasicUser? {
        didSet { playerLabel.text = player!.username }
    }
    
    var numPoints : Int = 0 {
        didSet {
            pointsLabel.text = String(numPoints)
            mainTrackingViewController!.pointsDidChange()
        }
    }
    
    var points : [Point] = [] {
        didSet{
            numPoints = Point.getScore(points: points)
        }
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
    
    // Mark: Outlet Functions
    @IBAction func regularButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .REGULAR, scorer: player!))
    }
    @IBAction func tinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .TINK, scorer: player!))
    }
    @IBAction func sinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .SINK, scorer: player!))
    }
    @IBAction func bounceSinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .BOUNCE_SINK, scorer: player!))
    }
    @IBAction func partnerSinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .PARTNER_SINK, scorer: player!))
    }
    @IBAction func selfSinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .SELF_SINK, scorer: player!))
    }
    @IBAction func fifaButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .FIFA, scorer: player!))
    }
    @IBAction func fieldGoalButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .FIELD_GOAL, scorer: player!))
    }
    @IBAction func fiveButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .FIVE, scorer: player!))
    }
    
    @IBAction func pointsButtonPressed(_ sender: Any) {
        mainTrackingViewController!.currentlyPickedPoints = playerNumber - 1
        mainTrackingViewController!.performSegue(withIdentifier: "toPlayerPoints", sender: self)
    }
}
