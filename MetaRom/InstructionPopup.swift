//
//  InstructionPopup.swift
//  MetaRom
//
//  Created by A Dey on 2023-03-10.
//  Copyright © 2023 MBIENTLAB, INC. All rights reserved.
//

import UIKit

class InstructionPopup: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var instructionText: UILabel!
    
    @IBAction func doneAction(_ sender: UIButton) {
        hide()
    }
    
    init() {
        super.init(nibName: "InstructionPopup", bundle: nil)
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
        self.backView.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        self.contentView.alpha = 0
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.shadowRadius = 4
        self.contentView.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.25)
        
        instructionText.textColor = .black
        instructionText.contentMode = .scaleToFill
        instructionText.numberOfLines = 0
        instructionText.text = "Stand with your arm to your side and your palm facing your body. \n Slowly raise your arm to a 90 degree angle. Be sure not to raise your shoulders. \n Hold your arm at 90 degrees for 1 second. \n Lower your arm back to your side."
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
