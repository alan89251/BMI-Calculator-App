//
//  PersonalInformationScreenViewController.swift
//  BMI Calculator App
//
//  Created by bee on 13/12/2022.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiRecordList = BMIRecordList.sharedBMIRecordList
        personalInformation = PersonalInformationScreenSetting.sharedPersonalInformationScreenSetting
        
        // set the UIs by the settings loaded from the persistent storage
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
        if (personalInformation.getUnit() == nil) {
            unitSegmentedControl.selectedSegmentIndex = 0
        }
        else if (personalInformation.getUnit()! == "Metric") {
            unitSegmentedControl.selectedSegmentIndex = 0
        }
        else {
            unitSegmentedControl.selectedSegmentIndex = 1
        }
        
        // set the UIs of the BMI score and BMI message
        if (personalInformation.getHeight() != nil && personalInformation.getWeight() != nil) {
            var bmiScore = calculateBMI(height: personalInformation.getHeight()!, weight: personalInformation.getWeight()!, unit: personalInformation.getUnit()!)
            // round the bmi score to 1 d.p.
            bmiScore = round(bmiScore * 10.0) / 10.0
            bmiScoreLabel.text = String(bmiScore)
            
            bmiMessageLabel.text = getBMIMessage(bmiScore: bmiScore)
        }
        
    }
    
    @IBAction func btnSubmit_onTouchUpInside(_ sender: UIButton) {
        // save personal information to the persistent storage
        let name = nameTextField.text!
        personalInformation.setName(name: name)
        let age = Int(ageTextField.text!)!
        personalInformation.setAge(age: age)
        let gender = genderTextField.text!
        personalInformation.setGender(gender: gender)
        let height = Double(heightTextField.text!)!
        personalInformation.setHeight(height: height)
        let weight = Double(weightTextField.text!)!
        personalInformation.setWeight(weight: weight)
        let unit = unitSegmentedControl.titleForSegment(at: unitSegmentedControl.selectedSegmentIndex)!
        personalInformation.setUnit(unit: unit)
        
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
    }
    
    @IBAction func btnDone_onTouchUpInside(_ sender: UIButton) {
        // navigate to the BMI Tracking screen
        self.tabBarController?.selectedIndex = 1
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
}
