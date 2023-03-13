//
//  PausePopup.swift
//  MetaRom
//
//  Created by A Dey on 2023-03-11.
//  Copyright © 2023 MBIENTLAB, INC. All rights reserved.
//

import UIKit

class PausePopup: UIViewController {

    @IBOutlet weak var exercisePausedLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var resumeLabel: UIView!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var finishLabel: UIView!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var quitLabel: UIView!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var instructionLabel: UIView!
    @IBOutlet weak var instructionButton: UIButton!
    
    var streamProcessor: StreamProcessor!
    var patient: Patient!
    
    @IBAction func doneAction(_ sender: UIButton) {
        hide()
    }
    
    
    //not sure how
    @IBAction func saveExit(_ sender: Any) {
    }
    
    
    //not sure how - maybe call parent function?
    @IBAction func quitExit(_ sender: Any) {
    }
    
    @IBAction func viewInstructions(_ sender: Any) {
        let instructionPopup = InstructionPopup()
        instructionPopup.appear(sender: self)
    }
    
    init() {
        super.init(nibName: "PausePopup", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configView()
    }
    
    func configView() {
        self.view.backgroundColor = .clear
        self.backView.backgroundColor = .salt.withAlphaComponent(0.65)
        self.contentView.backgroundColor = .white
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        self.contentView.addShadow(color: UIColor(red:0, green: 0, blue: 0, alpha: 1),
                                        alpha: 0.25,
                                        x: 0,
                                        y: 4,
                                        blur: 4,
                                        spread: 0)
        
        resumeLabel.layer.cornerRadius = 20
        resumeLabel.layer.masksToBounds =  true
        resumeLabel.backgroundColor = UIColor.amethyst
        resumeButton.titleLabel?.font = UIFont.textStyle7

        finishLabel.layer.cornerRadius = 18
        finishLabel.layer.masksToBounds =  true
        finishLabel.layer.borderColor = UIColor.pebble.cgColor
        finishLabel.layer.borderWidth =  2
        finishLabel.backgroundColor = UIColor.daisy
        finishButton.setTitleColor(UIColor.pebble, for: .normal)
        finishButton.titleLabel?.font = UIFont.textStyle7

        quitLabel.layer.cornerRadius = 18
        quitLabel.layer.masksToBounds =  true
        quitLabel.layer.borderColor = UIColor.pebble.cgColor
        quitLabel.layer.borderWidth =  2
        quitLabel.backgroundColor = UIColor.daisy
        quitButton.setTitleColor(UIColor.pebble, for: .normal)
        quitButton.titleLabel?.font = UIFont.textStyle7


        instructionLabel.layer.cornerRadius = 18
        instructionLabel.layer.masksToBounds =  true
        instructionLabel.layer.borderColor = UIColor.pebble.cgColor
        instructionLabel.layer.borderWidth =  2
        instructionLabel.backgroundColor = UIColor.daisy
        instructionButton.setTitleColor(UIColor.pebble, for: .normal)
        instructionButton.titleLabel?.font = UIFont.textStyle7
        
        exercisePausedLabel.textColor = UIColor.pebble
        exercisePausedLabel.font = UIFont.textStyle
        exercisePausedLabel.textAlignment = .center
    }
    
    func appear(sender: UIViewController) {
        sender.present(self, animated: false) {
            self.show()
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) {
            self.backView.alpha = 1
            self.contentView.alpha = 1
        } completion: { _ in
            self.dismiss(animated: false)
            self.removeFromParent()
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
