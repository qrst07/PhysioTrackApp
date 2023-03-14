//
//  PlaylistViewController.swift
//  MetaRom
//
//  Created by A Dey on 2023-03-14.
//  Copyright © 2023 MBIENTLAB, INC. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var scrollAll: UIScrollView!
    @IBOutlet private weak var scrollAllContentView: UIView!
    @IBOutlet private weak var rectangle22View: UIView!
    @IBOutlet private weak var chevronleftImageView: UIImageView!
    @IBOutlet private weak var rotatorCuffInjuryLabel: UILabel!
    @IBOutlet private weak var startedJanuary19th2023Label: UILabel!
    @IBOutlet private weak var exercisesLabel: UILabel!
    @IBOutlet private weak var scheduleImageView: UIImageView!
    @IBOutlet private weak var daysLeftLabel: UILabel!
    @IBOutlet private weak var rectangle14View: UIView!
    @IBOutlet private weak var group93ImageView: UIImageView!
    @IBOutlet private weak var beginPlaylistLabel: UILabel!
    @IBOutlet private weak var rectangle13View: UIView!
    @IBOutlet private weak var shoulderAbductionsLabel: UILabel!
    @IBOutlet private weak var group231ImageView: UIImageView!
    @IBOutlet private weak var setsOf15RepsLabel: UILabel!
    @IBOutlet private weak var group31ImageView: UIImageView!
    @IBOutlet private weak var scheduleImageView2: UIImageView!
    @IBOutlet private weak var daysLeftLabel2: UILabel!
    @IBOutlet private weak var sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView: UIView!
    @IBOutlet private weak var labelLabel: UILabel!
    @IBOutlet private weak var bookmarkImageView: UIImageView!
    @IBOutlet private weak var group25ImageView: UIImageView!
    @IBOutlet private weak var rectangle13View2: UIView!
    @IBOutlet private weak var elbowFlexionLabel: UILabel!
    @IBOutlet private weak var group23ImageView: UIImageView!
    @IBOutlet private weak var setsOf15RepsLabel2: UILabel!
    @IBOutlet private weak var group31ImageView2: UIImageView!
    @IBOutlet private weak var scheduleImageView3: UIImageView!
    @IBOutlet private weak var daysLeftLabel3: UILabel!
    @IBOutlet private weak var sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView2: UIView!
    @IBOutlet private weak var labelLabel2: UILabel!
    @IBOutlet private weak var bookmarkImageView2: UIImageView!
    @IBOutlet private weak var group25ImageView2: UIImageView!
    @IBOutlet private weak var rectangle13View3: UIView!
    @IBOutlet private weak var elbowFlexion2Label: UILabel!
    @IBOutlet private weak var group2311ImageView: UIImageView!
    @IBOutlet private weak var setsOf15RepsLabel3: UILabel!
    @IBOutlet private weak var group31ImageView3: UIImageView!
    @IBOutlet private weak var scheduleImageView4: UIImageView!
    @IBOutlet private weak var daysLeftLabel4: UILabel!
    @IBOutlet private weak var sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView3: UIView!
    @IBOutlet private weak var labelLabel3: UILabel!
    @IBOutlet private weak var bookmarkImageView3: UIImageView!
    @IBOutlet private weak var group25ImageView3: UIImageView!
    @IBOutlet private weak var tabBarView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var iconImageView2: UIImageView!
    @IBOutlet private weak var iconImageView3: UIImageView!
    @IBOutlet private weak var homeIndicatorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupSubViews()
    }

}

extension PlaylistViewController {
    private func setupViews() {

        self.view.backgroundColor = UIColor.daisy


        self.view.backgroundColor = UIColor.daisy


        rectangle22View.layer.borderColor = UIColor.indigo.cgColor
        rectangle22View.layer.borderWidth =  1
        rectangle22View.backgroundColor = UIColor.daisy


        rotatorCuffInjuryLabel.textColor = UIColor.indigo
        rotatorCuffInjuryLabel.numberOfLines = 0
        rotatorCuffInjuryLabel.font = UIFont.textStyle8
        rotatorCuffInjuryLabel.textAlignment = .left
        rotatorCuffInjuryLabel.text = NSLocalizedString("rotator.cuff.injury", comment: "")

        startedJanuary19th2023Label.textColor = UIColor.indigo
        startedJanuary19th2023Label.numberOfLines = 0
        startedJanuary19th2023Label.font = UIFont.textStyle9
        startedJanuary19th2023Label.textAlignment = .left
        startedJanuary19th2023Label.text = NSLocalizedString("started.january.19th.2023", comment: "")

        exercisesLabel.textColor = UIColor.indigo
        exercisesLabel.numberOfLines = 0
        exercisesLabel.font = UIFont.textStyle9
        exercisesLabel.textAlignment = .left
        exercisesLabel.text = NSLocalizedString(".exercises", comment: "")

        daysLeftLabel.textColor = UIColor.indigo
        daysLeftLabel.numberOfLines = 0
        daysLeftLabel.font = UIFont.textStyle9
        daysLeftLabel.textAlignment = .left
        daysLeftLabel.text = NSLocalizedString(".days.left", comment: "")

        rectangle14View.layer.cornerRadius = 30
        rectangle14View.layer.masksToBounds =  true
        rectangle14View.backgroundColor = UIColor.indigo


        beginPlaylistLabel.textColor = UIColor.daisy
        beginPlaylistLabel.numberOfLines = 0
        beginPlaylistLabel.font = UIFont.textStyle4
        beginPlaylistLabel.textAlignment = .left
        beginPlaylistLabel.text = NSLocalizedString("begin.playlist", comment: "")

        rectangle13View.layer.cornerRadius = 20
        rectangle13View.layer.masksToBounds =  true
        rectangle13View.backgroundColor = UIColor.indigo


        shoulderAbductionsLabel.textColor = UIColor.daisy
        shoulderAbductionsLabel.numberOfLines = 0
        shoulderAbductionsLabel.font = UIFont.textStyle10
        shoulderAbductionsLabel.textAlignment = .left
        shoulderAbductionsLabel.text = NSLocalizedString("shoulder.abductions", comment: "")

        setsOf15RepsLabel.textColor = UIColor.daisy
        setsOf15RepsLabel.numberOfLines = 0
        setsOf15RepsLabel.font = UIFont.textStyle11
        setsOf15RepsLabel.textAlignment = .left
        setsOf15RepsLabel.text = NSLocalizedString(".sets.of.15.reps", comment: "")

        daysLeftLabel2.textColor = UIColor.daisy
        daysLeftLabel2.numberOfLines = 0
        daysLeftLabel2.font = UIFont.textStyle11
        daysLeftLabel2.textAlignment = .left
        daysLeftLabel2.text = NSLocalizedString(".days.left2", comment: "")

        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView.layer.cornerRadius = 16
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView.layer.masksToBounds =  true
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView.backgroundColor = UIColor.daisy


        labelLabel.textColor = UIColor.indigo
        labelLabel.numberOfLines = 0
        labelLabel.font = UIFont.textStyle12
        labelLabel.textAlignment = .center
        labelLabel.text = NSLocalizedString("start.exercise", comment: "")

        rectangle13View2.layer.cornerRadius = 20
        rectangle13View2.layer.masksToBounds =  true
        rectangle13View2.backgroundColor = UIColor.indigo


        elbowFlexionLabel.textColor = UIColor.daisy
        elbowFlexionLabel.numberOfLines = 0
        elbowFlexionLabel.font = UIFont.textStyle10
        elbowFlexionLabel.textAlignment = .left
        elbowFlexionLabel.text = NSLocalizedString("elbow.flexion", comment: "")

        setsOf15RepsLabel2.textColor = UIColor.daisy
        setsOf15RepsLabel2.numberOfLines = 0
        setsOf15RepsLabel2.font = UIFont.textStyle11
        setsOf15RepsLabel2.textAlignment = .left
        setsOf15RepsLabel2.text = NSLocalizedString(".sets.of.15.reps", comment: "")

        daysLeftLabel3.textColor = UIColor.daisy
        daysLeftLabel3.numberOfLines = 0
        daysLeftLabel3.font = UIFont.textStyle11
        daysLeftLabel3.textAlignment = .left
        daysLeftLabel3.text = NSLocalizedString(".days.left2", comment: "")

        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView2.layer.cornerRadius = 16
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView2.layer.masksToBounds =  true
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView2.backgroundColor = UIColor.daisy


        labelLabel2.textColor = UIColor.indigo
        labelLabel2.numberOfLines = 0
        labelLabel2.font = UIFont.textStyle12
        labelLabel2.textAlignment = .center
        labelLabel2.text = NSLocalizedString("start.exercise", comment: "")

        rectangle13View3.layer.cornerRadius = 20
        rectangle13View3.layer.masksToBounds =  true
        rectangle13View3.backgroundColor = UIColor.indigo


        elbowFlexion2Label.textColor = UIColor.daisy
        elbowFlexion2Label.numberOfLines = 0
        elbowFlexion2Label.font = UIFont.textStyle10
        elbowFlexion2Label.textAlignment = .left
        elbowFlexion2Label.text = NSLocalizedString("elbow.flexion.2", comment: "")

        setsOf15RepsLabel3.textColor = UIColor.daisy
        setsOf15RepsLabel3.numberOfLines = 0
        setsOf15RepsLabel3.font = UIFont.textStyle11
        setsOf15RepsLabel3.textAlignment = .left
        setsOf15RepsLabel3.text = NSLocalizedString(".sets.of.15.reps", comment: "")

        daysLeftLabel4.textColor = UIColor.daisy
        daysLeftLabel4.numberOfLines = 0
        daysLeftLabel4.font = UIFont.textStyle11
        daysLeftLabel4.textAlignment = .left
        daysLeftLabel4.text = NSLocalizedString(".days.left2", comment: "")

        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView3.layer.cornerRadius = 16
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView3.layer.masksToBounds =  true
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView3.backgroundColor = UIColor.daisy


        labelLabel3.textColor = UIColor.indigo
        labelLabel3.numberOfLines = 0
        labelLabel3.font = UIFont.textStyle12
        labelLabel3.textAlignment = .center
        labelLabel3.text = NSLocalizedString("start.exercise", comment: "")

        tabBarView.layer.borderColor = UIColor.indigo.cgColor
        tabBarView.layer.borderWidth =  2
        tabBarView.backgroundColor = UIColor.daisy


        homeIndicatorView.layer.cornerRadius = 3
        homeIndicatorView.layer.masksToBounds =  true
        homeIndicatorView.backgroundColor = UIColor.daisy



    }

    private func setupSubViews() {


        rectangle22View.addShadow(color: UIColor(red:0, green: 0, blue: 0, alpha: 1),
                            alpha: 0.25,
                            x: 0,
                            y: 4,
                            blur: 4,
                            spread: 0)






        rectangle14View.addShadow(color: UIColor(red:0, green: 0, blue: 0, alpha: 1),
                            alpha: 0.25,
                            x: 0,
                            y: 4,
                            blur: 4,
                            spread: 0)



        rectangle13View.addShadow(color: UIColor(red:0, green: 0, blue: 0, alpha: 1),
                            alpha: 0.25,
                            x: 0,
                            y: 4,
                            blur: 4,
                            spread: 0)







        rectangle13View2.addShadow(color: UIColor(red:0, green: 0, blue: 0, alpha: 1),
                            alpha: 0.25,
                            x: 0,
                            y: 4,
                            blur: 4,
                            spread: 0)







        rectangle13View3.addShadow(color: UIColor(red:0, green: 0, blue: 0, alpha: 1),
                            alpha: 0.25,
                            x: 0,
                            y: 4,
                            blur: 4,
                            spread: 0)










    }

    private func setupLayout() {
        //Constraints are defined in Storyboard file.
    }

}

