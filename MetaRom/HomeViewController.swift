//
//  HomeViewController.swift
//  MetaRom
//
//  Created by A Dey on 2023-03-14.
//  Copyright © 2023 MBIENTLAB, INC. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
//    var coordinator: MainCoordinator?

    // MARK: - Properties
    @IBOutlet private weak var homeScroll: UIScrollView!
    @IBOutlet private weak var homeScrollContentView: UIView!
    @IBOutlet private weak var helloSamsonLabel: UILabel!
    @IBOutlet private weak var emojiWavingHandImageView: UIImageView!
    @IBOutlet private weak var yourExercisePlaylistsLabel: UILabel!
    @IBOutlet private weak var rectangle13View2: UIView!
    @IBOutlet private weak var rotatorCuffInjuryLabel: UILabel!
    @IBOutlet private weak var group48rcman21ImageView: UIImageView!
    @IBOutlet private weak var exercisesLabel2: UILabel!
    @IBOutlet private weak var daysLeftLabel2: UILabel!
    @IBOutlet private weak var scheduleImageView: UIImageView!
    @IBOutlet private weak var sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView2: UIView!
    @IBOutlet private weak var labelLabel2: UILabel!
    @IBOutlet private weak var bookmarkImageView2: UIImageView!
    @IBOutlet private weak var group25ImageView2: UIImageView!
    @IBOutlet private weak var rectangle13View: UIView!
    @IBOutlet private weak var carpelTunnelSyndromeLabel: UILabel!
    @IBOutlet private weak var group49ctman1ImageView: UIImageView!
    @IBOutlet private weak var exercisesLabel: UILabel!
    @IBOutlet private weak var daysLeftLabel: UILabel!
    @IBOutlet private weak var group92ImageView: UIImageView!
    @IBOutlet private weak var sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView: UIView!
    @IBOutlet private weak var labelLabel: UILabel!
    @IBOutlet private weak var bookmarkImageView: UIImageView!
    @IBOutlet private weak var group25ImageView: UIImageView!
    @IBOutlet private weak var howAreYouFeelingTodayLabel: UILabel!
    @IBOutlet private weak var rectangle151View: UIView!
    @IBOutlet private weak var rectangle151View2: UIView!
    @IBOutlet private weak var rectangle151View3: UIView!
    @IBOutlet private weak var iconEmojiSadImageView: UIImageView!
    @IBOutlet private weak var iconEmojiImageView: UIImageView!
    @IBOutlet private weak var greatLabel: UILabel!
    @IBOutlet private weak var iconEmojiMehImageView: UIImageView!
    @IBOutlet private weak var okayLabel: UILabel!
    @IBOutlet private weak var stiffLabel: UILabel!
    @IBOutlet private weak var yourProgressLabel: UILabel!
    @IBOutlet private weak var rectangle19View: UIView!
    @IBOutlet private weak var body1Label: UILabel!
    @IBOutlet private weak var group98ImageView: UIImageView!
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

extension HomeViewController {
    private func setupViews() {

        self.view.backgroundColor = UIColor.daisy


        self.view.backgroundColor = UIColor.daisy


        helloSamsonLabel.textColor = UIColor.indigo
        helloSamsonLabel.numberOfLines = 0
        helloSamsonLabel.font = UIFont.textStyle8
        helloSamsonLabel.textAlignment = .left
        helloSamsonLabel.text = NSLocalizedString("hello.samson", comment: "")

        yourExercisePlaylistsLabel.textColor = UIColor.indigo
        yourExercisePlaylistsLabel.numberOfLines = 0
        yourExercisePlaylistsLabel.font = UIFont.textStyle13
        yourExercisePlaylistsLabel.textAlignment = .left
        yourExercisePlaylistsLabel.text = NSLocalizedString("your.exercise.playlists", comment: "")

        rectangle13View2.layer.cornerRadius = 20
        rectangle13View2.layer.masksToBounds =  true
        rectangle13View2.backgroundColor = UIColor.indigo


        rotatorCuffInjuryLabel.textColor = UIColor.daisy
        rotatorCuffInjuryLabel.numberOfLines = 0
        rotatorCuffInjuryLabel.font = UIFont.textStyle4
        rotatorCuffInjuryLabel.textAlignment = .left
        rotatorCuffInjuryLabel.text = NSLocalizedString("rotator.cuff.injury", comment: "")

        exercisesLabel2.textColor = UIColor.daisy
        exercisesLabel2.numberOfLines = 0
        exercisesLabel2.font = UIFont.textStyle9
        exercisesLabel2.textAlignment = .left
        exercisesLabel2.text = NSLocalizedString(".home.exercises2", comment: "")

        daysLeftLabel2.textColor = UIColor.daisy
        daysLeftLabel2.numberOfLines = 0
        daysLeftLabel2.font = UIFont.textStyle9
        daysLeftLabel2.textAlignment = .left
        daysLeftLabel2.text = NSLocalizedString(".home.days.left2", comment: "")

        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView2.layer.cornerRadius = 16
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView2.layer.masksToBounds =  true
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView2.backgroundColor = UIColor.daisy


        labelLabel2.textColor = UIColor.indigo
        labelLabel2.numberOfLines = 0
        labelLabel2.font = UIFont.textStyle12
        labelLabel2.textAlignment = .center
        labelLabel2.text = NSLocalizedString("start.training", comment: "")

        rectangle13View.layer.cornerRadius = 20
        rectangle13View.layer.masksToBounds =  true
        rectangle13View.backgroundColor = UIColor.indigo


        carpelTunnelSyndromeLabel.textColor = UIColor.daisy
        carpelTunnelSyndromeLabel.numberOfLines = 0
        carpelTunnelSyndromeLabel.font = UIFont.textStyle4
        carpelTunnelSyndromeLabel.textAlignment = .left
        carpelTunnelSyndromeLabel.text = NSLocalizedString("carpel.tunnel.syndrome", comment: "")

        exercisesLabel.textColor = UIColor.daisy
        exercisesLabel.numberOfLines = 0
        exercisesLabel.font = UIFont.textStyle9
        exercisesLabel.textAlignment = .left
        exercisesLabel.text = NSLocalizedString(".exercises", comment: "")

        daysLeftLabel.textColor = UIColor.daisy
        daysLeftLabel.numberOfLines = 0
        daysLeftLabel.font = UIFont.textStyle9
        daysLeftLabel.textAlignment = .left
        daysLeftLabel.text = NSLocalizedString(".home.days.left", comment: "")

        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView.layer.cornerRadius = 16
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView.layer.masksToBounds =  true
        sizesTypefillIconleftIconCornerRadiuscorners8StateregularStretchtrueView.backgroundColor = UIColor.daisy


        labelLabel.textColor = UIColor.indigo
        labelLabel.numberOfLines = 0
        labelLabel.font = UIFont.textStyle12
        labelLabel.textAlignment = .center
        labelLabel.text = NSLocalizedString("start.training", comment: "")

        howAreYouFeelingTodayLabel.textColor = UIColor.indigo
        howAreYouFeelingTodayLabel.numberOfLines = 0
        howAreYouFeelingTodayLabel.font = UIFont.textStyle13
        howAreYouFeelingTodayLabel.textAlignment = .left
        howAreYouFeelingTodayLabel.text = NSLocalizedString("how.are.you.feeling.today", comment: "")

        rectangle151View.layer.cornerRadius = 20
        rectangle151View.layer.masksToBounds =  true
        rectangle151View.backgroundColor = UIColor.indigo


        rectangle151View2.layer.cornerRadius = 20
        rectangle151View2.layer.masksToBounds =  true
        rectangle151View2.backgroundColor = UIColor.indigo


        rectangle151View3.layer.cornerRadius = 20
        rectangle151View3.layer.masksToBounds =  true
        rectangle151View3.backgroundColor = UIColor.indigo


        greatLabel.textColor = UIColor.daisy
        greatLabel.numberOfLines = 0
        greatLabel.font = UIFont.textStyle13
        greatLabel.textAlignment = .center
        greatLabel.text = NSLocalizedString("great", comment: "")

        okayLabel.textColor = UIColor.daisy
        okayLabel.numberOfLines = 0
        okayLabel.font = UIFont.textStyle13
        okayLabel.textAlignment = .center
        okayLabel.text = NSLocalizedString("okay", comment: "")

        stiffLabel.textColor = UIColor.daisy
        stiffLabel.numberOfLines = 0
        stiffLabel.font = UIFont.textStyle13
        stiffLabel.textAlignment = .center
        stiffLabel.text = NSLocalizedString("stiff", comment: "")

        yourProgressLabel.textColor = UIColor.indigo
        yourProgressLabel.numberOfLines = 0
        yourProgressLabel.font = UIFont.textStyle13
        yourProgressLabel.textAlignment = .left
        yourProgressLabel.text = NSLocalizedString("your.progress", comment: "")

        rectangle19View.layer.cornerRadius = 20
        rectangle19View.layer.masksToBounds =  true
        rectangle19View.layer.borderColor = UIColor.indigo.cgColor
        rectangle19View.layer.borderWidth =  3
        rectangle19View.backgroundColor = UIColor.daisy

        body1Label.textColor = UIColor.indigo
        body1Label.numberOfLines = 0
        body1Label.font = UIFont.textStyle
        body1Label.textAlignment = .left
        body1Label.text = NSLocalizedString("exercise.accuracy", comment: "")

        tabBarView.layer.borderColor = UIColor.indigo.cgColor
        tabBarView.layer.borderWidth =  2
        tabBarView.backgroundColor = UIColor.daisy


        homeIndicatorView.layer.cornerRadius = 3
        homeIndicatorView.layer.masksToBounds =  true
        homeIndicatorView.backgroundColor = UIColor.daisy



    }

    private func setupSubViews() {




        rectangle13View2.addShadow(color: UIColor(red:0, green: 0, blue: 0, alpha: 1),
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















        rectangle19View.addShadow(color: UIColor(red:0, green: 0, blue: 0, alpha: 1),
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

