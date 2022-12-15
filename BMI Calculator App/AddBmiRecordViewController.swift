//
//  AddBmiRecordViewController.swift
//  BMI Calculator App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 15/12/2022
//  Changes: Implement the logic for the UI controls
//

import UIKit

/// view controller for adding a bmi record to the list
class AddBmiRecordViewController: UIViewController {
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private var bmiRecordList: BMIRecordList!
    private var personalInformation: PersonalInformationScreenSetting!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiRecordList = BMIRecordList.sharedBMIRecordList
        personalInformation = PersonalInformationScreenSetting.sharedPersonalInformationScreenSetting
        
        // config the UI
        datePicker.datePickerMode = UIDatePicker.Mode.date
    }

    /// do the actions when user click the submit button
    @IBAction func btnSubmit_onTouchUpInside(_ sender: UIButton) {
        let height = personalInformation.getHeight()! // get the height from the user setting
        let weight = Double(weightTextField.text!)!
        let date = datePicker.date
        let unit = personalInformation.getUnit()! // get the unit of the weight and height from the user setting
        var bmiScore = calculateBMI(height: height, weight: weight, unit: unit)
        // round the bmi score to 1 d.p.
        bmiScore = round(bmiScore * 10.0) / 10.0
        
        // add the bmi record to the list and save it to persistent storage
        bmiRecordList.addRecord(bmiRecord: BMIRecord(id: "",
                                                     weight: weight,
                                                     bmi: bmiScore,
                                                     date: date)
        )
        
        // navigate to the BMI Tracking screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toVC = storyboard.instantiateViewController(withIdentifier: "BMITrackingScreen") as! BMITrackingScreenTableViewController
        self.navigationController?.pushViewController(toVC, animated: true)
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
}
