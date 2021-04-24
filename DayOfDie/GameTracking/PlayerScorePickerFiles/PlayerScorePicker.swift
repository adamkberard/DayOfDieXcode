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
    @IBOutlet weak var firstSecondButton: UIButton!
    @IBOutlet weak var secondSecondButton: UIButton!
    @IBOutlet weak var thirdSecondButton: UIButton!
    
    // Mark: My Vars
    var primaryButtons : [UIButton] = []
    var secondaryButtons : [UIButton] = []
    var player : BasicUser? {
        didSet { playerLabel.text = player!.username }
    }
    var teammate : BasicUser?
    var opponentOne : BasicUser? {
        didSet { firstSecondButton.setTitle(opponentOne!.username, for: .normal) }
    }
    var opponentTwo : BasicUser? {
        didSet { secondSecondButton.setTitle(opponentTwo!.username, for: .normal) }
    }
    var points : [Point] = [] {
        didSet { numPoints = Point.getScore(points: points) }
    }
    var numPoints : Int = 0 {
        didSet {
            pointsLabel.text = String(numPoints)
            mainTrackingViewController!.pointsDidChange()
        }
    }
    var currentlySelectedPoint : PointTypes?
    var mainTrackingViewController : MainTrackingViewController?
    var playerNumber : Int = 0
    
    
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
        
        // Groups the buttons for later
        primaryButtons.append(regularPointButton)
        primaryButtons.append(tinkButton)
        primaryButtons.append(sinkButton)
        primaryButtons.append(bounceSinkButton)
        primaryButtons.append(partnerSinkButton)
        primaryButtons.append(selfSinkButton)
        primaryButtons.append(fifaButton)
        primaryButtons.append(fieldGoalButton)
        primaryButtons.append(fiveButton)
        
        secondaryButtons.append(firstSecondButton)
        secondaryButtons.append(secondSecondButton)
        secondaryButtons.append(thirdSecondButton)
        
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
        points.append(Point(typeOfPoint: .REGULAR, scorer: player!, scoredOn: nil, scoredOnPosition: nil))
    }
    @IBAction func tinkButtonPressed(_ sender: Any) {
        currentlySelectedPoint = PointTypes.TINK
        showSecondaryButtons()
    }
    @IBAction func sinkButtonPressed(_ sender: Any) {
        currentlySelectedPoint = PointTypes.SINK
        showSecondaryButtons()
    }
    @IBAction func bounceSinkButtonPressed(_ sender: Any) {
        currentlySelectedPoint = PointTypes.BOUNCE_SINK
        showSecondaryButtons()
    }
    @IBAction func partnerSinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .PARTNER_SINK, scorer: player!, scoredOn: teammate, scoredOnPosition: nil))
    }
    @IBAction func selfSinkButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .SELF_SINK, scorer: player!, scoredOn: nil, scoredOnPosition: nil))
    }
    @IBAction func fifaButtonPressed(_ sender: Any) {
        currentlySelectedPoint = PointTypes.FIFA
        showSecondaryButtons()
    }
    @IBAction func fieldGoalButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: .FIELD_GOAL, scorer: player!, scoredOn: nil, scoredOnPosition: nil))
    }
    @IBAction func fiveButtonPressed(_ sender: Any) {
    }
    @IBAction func pointsButtonPressed(_ sender: Any) {
        mainTrackingViewController!.currentlyPickedPoints = playerNumber - 1
        mainTrackingViewController!.performSegue(withIdentifier: "toPlayerPoints", sender: self)
    }
    @IBAction func firstSecondButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: currentlySelectedPoint!, scorer: player!, scoredOn: opponentOne, scoredOnPosition: nil))
        currentlySelectedPoint = nil
        showPrimaryButtons()
    }
    @IBAction func secondSecondButtonPressed(_ sender: Any) {
        points.append(Point(typeOfPoint: currentlySelectedPoint!, scorer: player!, scoredOn: opponentTwo, scoredOnPosition: nil))
        currentlySelectedPoint = nil
        showPrimaryButtons()
    }
    @IBAction func thirdSecondButtonPressed(_ sender: Any) {
        currentlySelectedPoint = nil
        showPrimaryButtons()
    }
    
    func showSecondaryButtons(){
        // Hide all the standard buttons
        for button in primaryButtons {
            button.isHidden = true
        }
        for button in secondaryButtons {
            button.isHidden = false
        }
    }
    
    func showPrimaryButtons(){
        // Hide all the standard buttons
        for button in primaryButtons {
            button.isHidden = false
        }
        for button in secondaryButtons {
            button.isHidden = true
        }
    }
}
