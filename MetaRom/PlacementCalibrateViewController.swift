//
//  PlacementViewController.swift
//  MetaClinic
//
//  Created by Stephen Schiffli on 10/9/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import Instructions
import MetaWear
import MetaWearCpp

protocol PlacementCalibrateDelegate: class {
    func didFinish(_ controller: PlacementCalibrateViewController)
    func hidesBackButton(_ value: Bool)
}

class PlacementCalibrateViewController: UIViewController {
    @IBOutlet weak var placementImage: UIImageView!
    @IBOutlet weak var placementLabel: UILabel!
    @IBOutlet weak var calibrateActivity: UIActivityIndicatorView!
    @IBOutlet weak var mainButton: UIButton!
    
    
    @IBOutlet weak var buttonLabel: UIView!
    
    var streamProcessor: StreamProcessor!
    var isPlacement: Bool!
    var calibrateOnTable: Bool!
    weak var delegate: PlacementCalibrateDelegate?
    var coachMarksController: CoachMarksController?

    @IBOutlet weak var pageContainer: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideLoading()
        
        buttonLabel.layer.cornerRadius = 20
        buttonLabel.layer.masksToBounds =  true
        buttonLabel.backgroundColor = UIColor.indigo
        mainButton.titleLabel?.font = UIFont.textStyle7
        
        self.pageContainer.backgroundColor = .white
        self.pageContainer.layer.cornerRadius = 20
        self.pageContainer.layer.masksToBounds = true
        self.pageContainer.addShadow(color: UIColor(red:0, green: 0, blue: 0, alpha: 1),
                                        alpha: 0.25,
                                        x: 0,
                                        y: 4,
                                        blur: 4,
                                        spread: 0)
        
        placementImage.image = isPlacement ? UIImage(named:"sensorSetup1") : calibrateOnTable ?
            UIImage(named: "tablePlacement")! :
            streamProcessor.joint.placementImage
        placementLabel.text = isPlacement ?
            "Insert the blue sensor into the band pocket." :
            calibrateOnTable ?
                "Place sensors on flat surface as pictured, facing forward in same direction as patient." : "Wrap the band around your arm and secure it tightly."
        

        
        if isPlacement {
            if !Globals.seenPlacementPopup {
                Globals.seenPlacementPopup = true
                coachMarksController = CoachMarksController()
                coachMarksController!.dataSource = self
                coachMarksController!.overlay.backgroundColor = UIColor(white: 0.0, alpha: 0.65)
                coachMarksController!.overlay.isUserInteractionEnabled = true
                coachMarksController!.start(in: .newWindow(over: self, at: nil))
            }
        }
    }
    
    func hideLoading() {
        mainButton.setTitle(isPlacement ? " Next" : " Calibrate & Start Exercise", for: .normal)
        mainButton.titleLabel?.font = UIFont.textStyle7
        mainButton.isEnabled = true
        calibrateActivity.stopAnimating()
    }
    
    func showLoading() {
        mainButton.setTitle(nil, for: .normal)
        mainButton.titleLabel?.font = UIFont.textStyle7
        mainButton.isEnabled = false
        mainButton.setImage(nil, for: .normal)
        calibrateActivity.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        coachMarksController?.stop(immediately: true)
    }
    
    @IBAction func mainButtonPressed(_ sender: UIButton) {
        // Early exit if just in placment mode
        guard !isPlacement else {
            delegate?.didFinish(self)
            return
        }
        
        delegate?.hidesBackButton(true)
        sender.isEnabled = false
        showLoading()
        mainButton.isEnabled = false
        streamProcessor.doCalibration().continueWith(.mainThread) { [weak self] _ in
            if let _self = self {
                _self.streamProcessor.startStream()
                _self.delegate?.hidesBackButton(false)
                _self.delegate?.didFinish(_self) // i think this closes it
            }
        }
    }
}

extension PlacementCalibrateViewController: CoachMarksControllerDataSource {
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let hintText = "IMPORTANT: The Sensors are color coded and have a top and bottom."
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation, hintText: hintText)
        coachViews.bodyView.hintLabel.font = UIFont.systemFont(ofSize: 18.0)
        coachViews.bodyView.hintLabel.textColor = #colorLiteral(red: 0.4588235294, green: 0.5176470588, blue: 0.5254901961, alpha: 1)
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    /*func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let hintText = "IMPORTANT: The Sensors are color coded and have a top and bottom."
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation, hintText: hintText)
        coachViews.bodyView.hintLabel.font = UIFont.systemFont(ofSize: 18.0)
        coachViews.bodyView.hintLabel.textColor = #colorLiteral(red: 0.4588235294, green: 0.5176470588, blue: 0.5254901961, alpha: 1)
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }*/
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        var mark = coachMarksController.helper.makeCoachMark(for: placementImage)
        mark.maxWidth = 500
        return mark
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 1
    }
}
