//
//  CompletedExerciseViewController.swift
//  MetaRom
//
//  Created by A Dey on 2023-03-12.
//  Copyright © 2023 MBIENTLAB, INC. All rights reserved.
//

import UIKit

protocol EndSessionSavedDelegate: class {
    func testFinish()
}

class CompletedExerciseViewController: UIViewController {


    
    weak var delegate: EndSessionSavedDelegate?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        
                
    }
    
    
    @IBAction func finishSave(_ sender: Any) {
        delegate?.testFinish()
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
