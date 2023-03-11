//
//  SessionViewController.swift
//  MetaClinic
//
//  Created by Stephen Schiffli on 5/24/18.
//  Copyright © 2018 MBIENTLAB, INC. All rights reserved.
//

import UIKit
import SceneKit
import Charts
import MetaWear
import MetaWearCpp
import MBProgressHUD
import BoltsSwift
import CircularSlider
import Instructions
//import FirebaseAnalytics
import RealmSwift

fileprivate let maxSeconds = 20.0
fileprivate let repGoal = 10
fileprivate let measurementAverageDepth = 5
fileprivate let measurementSampleDelta = 0.1 // 10Hz

class SessionViewController: UIViewController {
    @IBOutlet weak var sessionData: UIView!
//    @IBOutlet weak var instructionButton: UIBarButtonItem!
    @IBOutlet weak var startSessionButton: UIButton!
    @IBOutlet weak var endSessionButton: UIButton!
    @IBOutlet weak var skeletonView: SkeletonView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sessionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var elapsedLabel: UILabel!
    @IBOutlet var infoLabels: [UILabel]!
    @IBOutlet var infoValues: [UILabel]!
    @IBOutlet weak var upperSensorStateLabel: UILabel!
    @IBOutlet weak var upperSensorColorView: UIView!
    @IBOutlet weak var upperSensorActivity: UIActivityIndicatorView!
    @IBOutlet weak var upperSensorBattery: UIImageView!
    @IBOutlet weak var lowerSensorStateLabel: UILabel!
    @IBOutlet weak var lowerSensorColorView: UIView!
    @IBOutlet weak var lowerSensorActivity: UIActivityIndicatorView!
    @IBOutlet weak var lowerSensorBattery: UIImageView!
    
    @IBOutlet weak var completeGraphView: UIView!
    @IBOutlet weak var lineChart: LineChartView!
    
    @IBOutlet weak var exerciseInfoView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var setCountLabel: UILabel!
    @IBOutlet weak var repCountLabel: UILabel!
    @IBOutlet weak var accuracyCountLabel: UILabel!
    @IBOutlet weak var progressCountLabel: UILabel!
    
    @IBOutlet weak var instructionButton: UIButton!
    @IBAction func showInstructions(_ sender: Any) {
        let instructionPopup = InstructionPopup()
        instructionPopup.appear(sender: self)
    }
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var nextExerciseButton: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    //var exerciseThreshold: ClosedRange<Double>!
    //let pickerViews = [
    //    UIPickerView(),
    //    UIPickerView()
    //]
    //var pickerValues: [[Double]] = [[], []]

    var patient: Patient!
    var sessionNumber: Int!
    var repCount = 0 {
        didSet {
            repCountUpdated()
        }
    }
    var incorrectRepCount = 0;
    var totalReps = 5;
    var totalSets = 3;
    var setCount = 1 {
        didSet {
            setCountUpdated()
        }
    }
    var checkingTop = false

    var measurementMap: [Measurement: MeasurementData] = [:]
    var overXSeconds = false
    var streamProcessor: StreamProcessor!
    //var exercise: ExerciseConfig?
    var streamStart: Date?
    var batteryCheckTime = Date()
    
    var exerciseComplete = false
    
    //var coachMarksController: CoachMarksController?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        //hide items
        feedbackLabel.isHidden = true
        sessionData.isHidden = true
        
        //items to appear when exercise is done
        nextExerciseButton.isHidden = true
        notesButton.isHidden = true
        endSessionButton.isHidden = true

        // Do any additional setup after loading the view.
        skeletonView.setupScene()
        progressView.progress = 0.0
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 4)

        skeletonView.setupConfig(config: streamProcessor.joint)
        
        loadFreeformMode()
        
//        upperSensorColorView.backgroundColor = streamProcessor.joint.upper.sensorColor.color
//        lowerSensorColorView.backgroundColor = streamProcessor.joint.lower.sensorColor.color
        
        streamProcessor.delegate = self
        streamProcessor.startStream()
//        updateButtonStates()
        startSessionPressed()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*if exercise != nil {
            if !Globals.seenSessionWalkthrough {
                Globals.seenSessionWalkthrough = true
                coachMarksController = CoachMarksController()
                coachMarksController!.dataSource = self
                coachMarksController!.overlay.backgroundColor = UIColor(white: 0.0, alpha: 0.65)
                coachMarksController!.overlay.isUserInteractionEnabled = true
                coachMarksController!.start(in: .newWindow(over: self, at: nil))
            }
        }*/
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //coachMarksController?.stop(immediately: true)
    }
        
    func loadFreeformMode() {
        //completeExerciseGameView.isHidden = true
        completeGraphView.isHidden = true
        exerciseInfoView.isHidden = false
    
                
        setCountLabel.text = "Set \(String(setCount)) of \(String(totalSets))"
        
        repCountLabel.text = "\(String(repCount)) of \(String(totalReps)) reps completed"
        
        var colors = graphLineColors.makeIterator()
        var values = infoValues.makeIterator()
        var labels = infoLabels.makeIterator()
        streamProcessor.joint.measurements.forEach {
            labels.next()?.text = $0.measurement.rawValue
            measurementMap[$0.measurement] = MeasurementData(
                measurement: $0.measurement,
                degreeLabel: values.next()!,
                lineChartDataSet: createSet(color: colors.next()!,
                                            title: $0.measurement.rawValue))
        }
        chartSetup(lineChart, dataSets: measurementMap.map { $0.value.lineChartDataSet! })
        
        while let value = values.next() { value.text = " " }
        while let label = labels.next() { label.text = " " }
        //infoTextFields.forEach { $0.isHidden = true }
    }
    
    /*func loadExerciseMode(_ exercise: ExerciseConfig) {
        completeGraphView.isHidden = true
        completeExerciseGameView.isHidden = false
        
        pickerViews.forEach { $0.delegate = self; $0.dataSource = self }
        infoTextFields.forEach { $0.delegate = self }
        
        exerciseThreshold = patient.exerciseThresholdRange(exercise)
        
        pickerValues = [
            Array(stride(from: exercise.barRange.lowerBound,
                         through: exercise.barRange.upperBound,
                         by: 5)),
            Array(stride(from: exercise.barRange.lowerBound,
                         through: exercise.barRange.upperBound,
                         by: 5))
        ]
        pickerValues[0].removeLast()
        pickerValues[1].removeFirst()

        checkingTop = exercise.repAtTop
        
        infoLabels.text = "Exercise Type"
        infoValues.text = exercise.name
        infoValues.font = UIFont.systemFont(ofSize: 15.0)
        
        for i in [0, 1] {
            let value = i == 0 ? exerciseThreshold.lowerBound : exerciseThreshold.upperBound
            infoLabels[i + 1].text = "Target \(exercise.thresholdNames[i])"
            infoValues[i + 1].text = " "
            infoTextFields.text = "\(Int(round(value)))°"
            infoTextFields[i].inputView = pickerViews[i]
            if let idx = pickerValues[i].firstIndex(of: value) {
                pickerViews[i].selectRow(idx, inComponent: 0, animated: false)
        }
        }

        repCount = 0
        measurementMap[exercise.measurement] = MeasurementData(measurement: exercise.measurement)
        instructionButton.isEnabled = true
    }*/
    
    func repCountUpdated() {
        //repSlider.setValue(Float(repCount), animated: true)
        //repLabel.text = "\(repCount)/\(repGoal)"
        repCountLabel.text = "\(String(repCount)) of \(String(totalReps)) reps completed"
        
        
        // PROGRESS BAR
        let progressCount = Float(1)/Float(totalReps)
                
        progressView.progress = Float(repCount)*progressCount
        progressView.setProgress(progressView.progress, animated: true)
    }
    
    func setCountUpdated() {
        setCountLabel.text = "\(String(setCount)) of \(String(totalSets)) sets completed"
    }
    
//    func updateButtonStates() {
//        // Only update buttons if not actively streaming
//        guard streamStart == nil else {
//            return
//        }
//        let allConnected = streamProcessor.allConnected
//        startSessionButton.isEnabled = allConnected
//    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm Exit", message: "Are you sure you want to exit this session?  This action cannot be undone.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Exit without saving", style: .destructive, handler: { _ in
            StreamProcessor.remove(patient: self.patient)
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Save and Exit", style: .destructive, handler: { _ in
            self.endSession()
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    func startSessionPressed() {
//        startSessionButton.isEnabled = false
        endSessionButton.isEnabled = true
        
        lineChart.xAxis.axisMinimum = 0.0
        lineChart.xAxis.axisMaximum = maxSeconds
        overXSeconds = false
        measurementMap.forEach {
            $0.value.lineChartDataSet?.removeAll(keepingCapacity: true)
            $0.value.sessionData.removeAll()
        }
        streamStart = Date()
        
        //Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            //AnalyticsParameterContentType: streamProcessor.joint.side.displayName + streamProcessor.joint.joint.rawValue,
            //AnalyticsParameterItemID: (exercise == nil) ? "Freeform" : exercise!.name
            //])
        
        //if let exercise = exercise {
        //    patient.updateExerciseThresholdRange(exercise.name, range: exerciseThreshold)
        //}
    }
    
    func endSession() {
        guard streamStart != nil else {
            return
        }
        streamProcessor.stopStream()
        do {
                try Session.saveNew(patient: patient,
                                    measurements: measurementMap.map { $0.value },
                                    side: streamProcessor.joint.side,
                                    joint: streamProcessor.joint.joint)
            //}
        } catch {
            self.showOkAlert(title: "Save Failed", message: "Please try again.\n\(error.localizedDescription)")
        }
        performSegue(withIdentifier: "backToPatient", sender: nil)
    }
    
    // for now, next exercise ends session as well
    @IBAction func endSessionPressed(_ sender: Any) {
            endSession()
    }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if let destination = segue.destination as? InstructionViewController {
    //        destination.exercise = exercise!
    //    }
    //}
}

/*extension SessionViewController: CoachMarksControllerDataSource {
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        let hintText: String
        switch index {
        case 0:
            hintText = "Tap to see exercise instructions."
        default:
            hintText = "Tap to change exercise targets (if needed) before starting the session."
        }
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation, hintText: hintText)
        coachViews.bodyView.hintLabel.font = UIFont.systemFont(ofSize: 18.0)
        coachViews.bodyView.hintLabel.textColor = #colorLiteral(red: 0.4588235294, green: 0.5176470588, blue: 0.5254901961, alpha: 1)
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {
        let hintText: String
        switch index {
        case 0:
            hintText = "Tap to see exercise instructions."
        default:
            hintText = "Tap to change exercise targets (if needed) before starting the session."
        }
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation, hintText: hintText)
        coachViews.bodyView.hintLabel.font = UIFont.systemFont(ofSize: 18.0)
        coachViews.bodyView.hintLabel.textColor = #colorLiteral(red: 0.4588235294, green: 0.5176470588, blue: 0.5254901961, alpha: 1)
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        let view: UIView
        switch index {
        case 0:
            view = instructionButton.value(forKey: "view") as! UIView
        default:
            view = infoTextFields[0]
        }
        var mark = coachMarksController.helper.makeCoachMark(for: view)
        mark.maxWidth = 500
        return mark
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 2
    }
}*/

/*extension SessionViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return streamStart == nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let idx = infoTextFields.firstIndex(of: textField)!
        let value = pickerValues[idx][pickerViews[idx].selectedRow(inComponent: 0)]
        if idx == 0 {
            if value >= exerciseThreshold.upperBound {
                let newUpper = pickerValues[1].first { $0 > value }!
                infoTextFields[1].text = "\(Int(round(newUpper)))°"
                exerciseThreshold = value...newUpper
            } else {
                exerciseThreshold = value...exerciseThreshold.upperBound
            }
        } else {
            if value <= exerciseThreshold.lowerBound {
                let newLower = pickerValues[0].last { $0 < value }!
                infoTextFields[0].text = "\(Int(round(newLower)))°"
                exerciseThreshold = newLower...value
            } else {
                exerciseThreshold = exerciseThreshold.lowerBound...value
            }
        }
    }
}*/

/*extension SessionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let idx = pickerViews.firstIndex(of: pickerView)!
        return pickerValues[idx].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let idx = pickerViews.firstIndex(of: pickerView)!
        let value = pickerValues[idx][row]
        let defaultVal = idx == 0 ?
            exercise!.exerciseThreshold.lowerBound :
            exercise!.exerciseThreshold.upperBound
        return "\(Int(round(value)))°\(Int(value) == Int(defaultVal) ? " (Default)" : "")"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let idx = pickerViews.firstIndex(of: pickerView)!
        let value = pickerValues[idx][row]
        infoTextFields[idx].text = "\(Int(round(value)))°"
    }
}*/

extension SessionViewController: StreamProcessorDelegate {
    func didFinish(isUpper: Bool, error: Error?) {
        if let error = error {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        } else {
            let label = isUpper ? upperSensorStateLabel : lowerSensorStateLabel
            let activity = isUpper ? upperSensorActivity : lowerSensorActivity
            DispatchQueue.main.async {
                activity!.stopAnimating()
                label!.text = "Active Now"
//                self.updateButtonStates()
            }
        }
    }
    
    func connecting(isUpper: Bool) {
        let label = isUpper ? upperSensorStateLabel : lowerSensorStateLabel
        let activity = isUpper ? upperSensorActivity : lowerSensorActivity
        DispatchQueue.main.async {
            activity!.startAnimating()
            label!.text = "Connecting..."
//            self.updateButtonStates()
        }
    }
    
    func newSample(upper: SCNQuaternion, lower: SCNQuaternion, measurements: [(Measurement, Double)]) {
        skeletonView.upperNode?.worldOrientation = upper
        skeletonView.lowerNode?.worldOrientation = lower
        updateBatteryIfNeeded()
        
        // Only process measurments if the stream has started
        guard let streamStart = streamStart else {
            return
        }
        var first = true
        measurements.forEach {
            if let data = measurementMap[$0.0] {
                processMeasurment(data: data, sample: $0.1, updateTimeUI: first, streamStart: streamStart)
                first = false
            }
        }
    }
    
    func updateBatteryIfNeeded() {
        guard batteryCheckTime.timeIntervalSinceNow < 0 else {
            return
        }
        batteryCheckTime = Date(timeIntervalSinceNow: 5*60*60)
        streamProcessor.upperStream.getBatteryCharge().continueWith { t in
            if let result = t.result {
                self.updateBatteryIcon(self.upperSensorBattery, charge: result)
            } else {
                self.batteryCheckTime = Date(timeIntervalSinceNow: 20)
            }
        }
        streamProcessor.lowerStream.getBatteryCharge().continueWith { t in
            if let result = t.result {
                self.updateBatteryIcon(self.lowerSensorBattery, charge: result)
            } else {
                self.batteryCheckTime = Date(timeIntervalSinceNow: 20)
            }
        }
    }
    
    func updateBatteryIcon(_ image: UIImageView, charge: UInt8) {
        let imageName: String
        if charge > 85 {
            imageName = "battery5"
        } else if charge > 70 {
            imageName = "battery4"
        } else if charge > 50 {
            imageName = "battery3"
        } else if charge > 35 {
            imageName = "battery2"
        } else if charge > 15 {
            imageName = "battery1"
        } else  {
            imageName = "battery0"
        }
        DispatchQueue.main.async {
            image.image = UIImage(named: imageName)
        }
    }
    
    func displayEndExercise() {
        progressView.isHidden = true
        pauseButton.isHidden = true
        closeButton.isHidden = true
        instructionButton.isHidden = true
        nextExerciseButton.isHidden = false
        notesButton.isHidden = false
        endSessionButton.isHidden = false
    }
    
    func processExercise(exercise: ExerciseConfig, currentValue: Double) {
        //increment reps
        // TODO: starting at 1? why
        let didCross = checkingTop ?
        currentValue > exercise.exerciseThreshold.upperBound :
        currentValue < exercise.exerciseThreshold.lowerBound
        if didCross {
            if checkingTop != exercise.repAtTop {
                repCount += 1
            }
            checkingTop = !checkingTop
        }
        
        //increment sets
        if repCount == totalReps {
            setCount += 1
            repCount = 0
            feedbackLabel.text = "Onto the next set!"
            self.feedbackLabel.isHidden = false
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   self.feedbackLabel.isHidden = true
               }
            
            //end session
            if (setCount > totalSets){
                setCountLabel.text = "Set \(String(totalSets)) of \(String(totalSets))"
                
                repCountLabel.text = "\(String(totalReps)) of \(String(totalReps)) reps completed"
                displayEndExercise()
            }
        }
        
        if (setCount == totalSets) && (repCount == totalReps-2) {
            feedbackLabel.text = "Almost done!"
            self.feedbackLabel.isHidden = false
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   self.feedbackLabel.isHidden = true
               }
        }
        
        if (currentValue > exercise.exerciseThreshold.upperBound) {
            feedbackLabel.text = "Lower your arm!"
            self.feedbackLabel.isHidden = false
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   self.feedbackLabel.isHidden = true
               }
        }
        
        if (currentValue > exercise.exerciseThreshold.upperBound+10) {
            feedbackLabel.text = "Don't shrug your shoulders!"
            self.feedbackLabel.isHidden = false
               DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   self.feedbackLabel.isHidden = true
               }
        }
    }
    
    func processMeasurment(data: MeasurementData, sample: Double, updateTimeUI: Bool, streamStart: Date) {
        data.averageBuffer.append(sample)
        if data.averageBuffer.count == measurementAverageDepth {
            let currentTime = Double(data.sessionData.count) * measurementSampleDelta
            if updateTimeUI {
                if currentTime > maxSeconds && !overXSeconds {
                    overXSeconds = true
                    lineChart.xAxis.resetCustomAxisMin()
                    lineChart.xAxis.resetCustomAxisMax()
                }
                let start = Date()
                elapsedLabel.text = start.differenceTo(start.addingTimeInterval(currentTime))
            }
            
            let currentValue = Double(data.averageBuffer.average)
            data.averageBuffer.removeAll(keepingCapacity: true)
            data.sessionData.append((streamStart.addingTimeInterval(currentTime), currentValue))
            data.degreeLabel?.text = "\(Int(round(currentValue)))°"
            
            if let lineChartDataSet = data.lineChartDataSet {
                lineChartDataSet.append(ChartDataEntry(x: currentTime, y: currentValue))
                if lineChartDataSet.count > Int(maxSeconds * 10) {
                    let _: ChartDataEntry = lineChartDataSet.removeFirst()
                }
                lineChart.data!.notifyDataChanged() // let the data know a dataSet changed
                lineChart.notifyDataSetChanged() // let the chart know it's data changed
                lineChartDataSet.notifyDataSetChanged()
            }
            
            //if let exercise = exercise {
            //    if exercise.measurement == data.measurement {
            //        processExercise(exercise: exercise, currentValue: currentValue)
            //    }
            //}
            
            if data.measurement == ExerciseConfig.shoulderAbduction.measurement{
                processExercise(exercise: ExerciseConfig.shoulderAbduction, currentValue: currentValue)
            }
        }
    }
    

}

class AlwaysPositiveAxisValueFormatter: AxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(format: "%d", Int(abs(value)))
    }
}

fileprivate func chartSetup(_ lineChart: LineChartView, dataSets: [LineChartDataSet]) {
    lineChart.dragEnabled = true
    lineChart.setScaleEnabled(false)
    lineChart.pinchZoomEnabled = false
    lineChart.doubleTapToZoomEnabled = false
    
    lineChart.highlightPerDragEnabled = false
    lineChart.highlightPerTapEnabled = false
    
    lineChart.xAxis.drawGridLinesEnabled = true
    lineChart.xAxis.drawAxisLineEnabled = false
    lineChart.xAxis.gridColor = .axisSilver
    lineChart.xAxis.gridLineWidth = 0.5
    lineChart.xAxis.labelPosition = .bottom
    lineChart.xAxis.labelTextColor = .white
    lineChart.xAxis.labelFont = UIFont.systemFont(ofSize: 14)
    lineChart.xAxis.axisMinimum = 0.0
    lineChart.xAxis.axisMaximum = maxSeconds
    
    lineChart.leftAxis.drawGridLinesEnabled = true
    lineChart.leftAxis.drawAxisLineEnabled = false
    lineChart.leftAxis.gridColor = .axisSilver
    lineChart.leftAxis.gridLineWidth = 0.5
    lineChart.leftAxis.labelTextColor = .white
    lineChart.leftAxis.labelFont = UIFont.systemFont(ofSize: 14)
    lineChart.leftAxis.valueFormatter = AlwaysPositiveAxisValueFormatter()
    
    lineChart.legend.form = .line
    lineChart.legend.formSize = 24
    lineChart.legend.formLineWidth = 2
    lineChart.legend.textColor = .white
    lineChart.legend.font = UIFont.systemFont(ofSize: 14)
    lineChart.legend.verticalAlignment = .top
    lineChart.legend.horizontalAlignment = .right
    
    lineChart.chartDescription.text = nil
    lineChart.rightAxis.enabled = false
    
    // Square up the scaling
//    lineChart.leftAxis.axisMaximum = maxValue
//    lineChart.leftAxis.axisMinimum = -maxValue
//    lineChart.xAxis.axisMaximum = maxValue
//    lineChart.xAxis.axisMinimum = -maxValue
    
    // Add a fat zero line
    zeroLine(lineChart)

    let data = LineChartData(dataSets: dataSets)
    lineChart.data = data
}

fileprivate func createSet(color: UIColor, title: String, entries: [ChartDataEntry] = [ChartDataEntry(x: 0, y: 0)]) -> LineChartDataSet {
    let set = LineChartDataSet(entries: entries, label: title)
    set.drawValuesEnabled = false
    set.drawCircleHoleEnabled = false
    set.drawCirclesEnabled = false
    set.setColor(color)
    set.lineWidth = 2
    set.mode = .cubicBezier
    return set
}

fileprivate func zeroLine(_ lineChart: LineChartView) {
    let ll = ChartLimitLine(limit: 0.0)
    ll.lineColor = .axisSilver
    ll.lineWidth = 1.0
    lineChart.leftAxis.addLimitLine(ll)
}
