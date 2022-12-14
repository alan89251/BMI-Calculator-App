//
//  PersonalInformationScreenViewController.swift
//  BMI Calculator App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 15/12/2022
//  Changes: Implement the logic for the UI controls
//

import UIKit

/// Manage the logic of the Personal Information Screen
class PersonalInformationScreenViewController: UIViewController {
    private var bmiRecordList: BMIRecordList!
    private var personalInformation: PersonalInformationScreenSetting!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bmiScoreLabel: UILabel!
    @IBOutlet weak var bmiMessageLabel: UILabel!
    @IBOutlet weak var bmiProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiRecordList = BMIRecordList.sharedBMIRecordList
        personalInformation = PersonalInformationScreenSetting.sharedPersonalInformationScreenSetting
        
        // set the style of the bmi progress bar
        bmiProgressView.transform = bmiProgressView.transform.scaledBy(x: 1, y: 4)
        bmiProgressView.layer.cornerRadius = 8
        bmiProgressView.clipsToBounds = true
        bmiProgressView.layer.sublayers![1].cornerRadius = 8
        bmiProgressView.subviews[1].clipsToBounds = true
        
        // set the UIs by the settings loaded from the persistent storage
        resetScreen()
    }
    
    /// handle the event when the submit button is clicked
    @IBAction func btnSubmit_onTouchUpInside(_ sender: UIButton) {
        // save personal information to the persistent storage
        if (nameTextField.text != nil && nameTextField.text! != "") {
            personalInformation.setName(name: nameTextField.text!)
        }
        if (ageTextField.text != nil && ageTextField.text! != "") {
            personalInformation.setAge(age: Int(ageTextField.text!)!)
        }
        if (genderTextField.text != nil && genderTextField.text! != "") {
            personalInformation.setGender(gender: genderTextField.text!)
        }
        var height = 0.0
        if (heightTextField.text != nil && heightTextField.text! != "") {
            height = Double(heightTextField.text!)!
            personalInformation.setHeight(height: height)
        }
        var weight = 0.0
        if (weightTextField.text != nil && weightTextField.text! != "") {
            weight = Double(weightTextField.text!)!
            personalInformation.setWeight(weight: weight)
        }
        let unit = unitSegmentedControl.titleForSegment(at: unitSegmentedControl.selectedSegmentIndex)!
        personalInformation.setUnit(unit: unit)
        
        // add the bmi record and set the UIs of the BMI score, BMI message, BMI progress bar
        if (heightTextField.text != nil && heightTextField.text! != ""
            && weightTextField.text != nil && weightTextField.text! != "") {
            var bmiScore = calculateBMI(height: height, weight: weight, unit: unit)
            // round the bmi score to 1 d.p.
            bmiScore = round(bmiScore * 10.0) / 10.0
            
            // add the bmi record to the list and save it into the persistant storage
            bmiRecordList.addRecord(bmiRecord: BMIRecord(id: "",
                                                         weight: weight,
                                                         bmi: bmiScore,
                                                         date: Date.now) // use current date as the date of the record
            )
            
            // display the BMI score and BMI message
            bmiScoreLabel.text = String(bmiScore)
            bmiMessageLabel.text = getBMIMessage(bmiScore: bmiScore)
            
            // set the colour and the progress of the progress bar in proportion to the user's BMI
            setBmiProgressBar(bmiScore: bmiScore)
        }
    }
    
    /// handle the event when the done button is clicked
    @IBAction func btnDone_onTouchUpInside(_ sender: UIButton) {
        // navigate to the BMI Tracking screen
        self.tabBarController?.selectedIndex = 1
    }
    
    /// reset the screen to its original state
    /// that set all the values of the UI controls to the values loaded from the persistent storage
    @IBAction func btnReset_onTouchUpInside(_ sender: UIButton) {
        resetScreen()
    }
    
    /// reset the UIs by the settings loaded from the persistent storage
    private func resetScreen() {
        nameTextField.text = personalInformation.getName() ?? ""
        ageTextField.text = personalInformation.getAge() != nil
            ? String(personalInformation.getAge()!)
            : ""
        genderTextField.text = personalInformation.getGender() ?? ""
        heightTextField.text = personalInformation.getHeight() != nil
            ? String(personalInformation.getHeight()!)
            : ""
        weightTextField.text = personalInformation.getWeight() != nil
            ? String(personalInformation.getWeight()!)
            : ""
        if (personalInformation.getUnit() == nil
            || personalInformation.getUnit()! == "") {
            unitSegmentedControl.selectedSegmentIndex = 0
        }
        else if (personalInformation.getUnit()! == "Metric") {
            unitSegmentedControl.selectedSegmentIndex = 0
        }
        else {
            unitSegmentedControl.selectedSegmentIndex = 1
        }
        
        // set the UIs of the BMI score, BMI message, BMI progress bar
        if (personalInformation.getHeight() != nil && personalInformation.getWeight() != nil) {
            var bmiScore = calculateBMI(height: personalInformation.getHeight()!, weight: personalInformation.getWeight()!, unit: personalInformation.getUnit()!)
            // round the bmi score to 1 d.p.
            bmiScore = round(bmiScore * 10.0) / 10.0
            bmiScoreLabel.text = String(bmiScore)
            bmiMessageLabel.text = getBMIMessage(bmiScore: bmiScore)
            
            // set the colour and the progress of the progress bar in proportion to the user's BMI
            setBmiProgressBar(bmiScore: bmiScore)
        }
    }
    
    /// calculate the BMI
    /// support metric and imperial units
    private func calculateBMI(height: Double, weight: Double, unit: String) -> Double {
        if (unit == "Metric") {
            return weight / (height * height)
        }
        else {
            return (weight * 703.0) / (height * height)
        }
    }
    
    /// get the message that indicates what category the user falls within for their current BMI score
    private func getBMIMessage(bmiScore: Double) -> String {
        if (bmiScore < 16.0) {
            return "Severe Thinness"
        }
        else if (bmiScore < 17.0) {
            return "Moderate Thinness"
        }
        else if (bmiScore < 18.5) {
            return "Mild Thinness"
        }
        else if (bmiScore < 25.0) {
            return "Normal"
        }
        else if (bmiScore < 30.0) {
            return "Overweight"
        }
        else if (bmiScore < 35.0) {
            return "Obese Class I"
        }
        else if (bmiScore <= 40.0) {
            return "Obese Class II"
        }
        else {
            return "Obese Class III"
        }
    }
    
    /// set the colour and the progress of the progress bar in proportion to the user's BMI
    private func setBmiProgressBar(bmiScore: Double) {
        if (bmiScore < 16.0) {
            bmiProgressView.progress = 0.125
            bmiProgressView.progressTintColor = UIColor.red
        }
        else if (bmiScore < 17.0) {
            bmiProgressView.progress = 0.25
            bmiProgressView.progressTintColor = UIColor.orange
        }
        else if (bmiScore < 18.5) {
            bmiProgressView.progress = 0.375
            bmiProgressView.progressTintColor = UIColor.yellow
        }
        else if (bmiScore < 25.0) {
            bmiProgressView.progress = 0.5
            bmiProgressView.progressTintColor = UIColor.green
        }
        else if (bmiScore < 30.0) {
            bmiProgressView.progress = 0.625
            bmiProgressView.progressTintColor = UIColor.yellow
        }
        else if (bmiScore < 35.0) {
            bmiProgressView.progress = 0.75
            bmiProgressView.progressTintColor = UIColor.orange
        }
        else if (bmiScore <= 40.0) {
            bmiProgressView.progress = 0.875
            bmiProgressView.progressTintColor = UIColor.red
        }
        else {
            bmiProgressView.progress = 1.0
            bmiProgressView.progressTintColor = UIColor.purple
        }
    }
}
