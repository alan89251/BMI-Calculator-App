//
//  UpdateBmiRecordViewController.swift
//  BMI Calculator App
//
//  Created by bee on 14/12/2022.
//

import UIKit

/// view controller for updating a bmi record
class UpdateBmiRecordViewController: UIViewController {
    private var bmiRecord: BMIRecord?
    public func setBmiRecord(bmiRecord: BMIRecord) {
        self.bmiRecord = bmiRecord
    }
    
    private var bmiRecordList: BMIRecordList!
    private var personalInformation: PersonalInformationScreenSetting!
    
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiRecordList = BMIRecordList.sharedBMIRecordList
        personalInformation = PersonalInformationScreenSetting.sharedPersonalInformationScreenSetting
        
        // set the value of the weight text field and the date picker to the values in the BMI record
        weightTextField.text = String(bmiRecord!.weight)
        datePicker.date = bmiRecord!.date
        datePicker.datePickerMode = UIDatePicker.Mode.date
    }

    /// do the actions when user click the submit button
    @IBAction func btnSubmit_onTouchUpInside(_ sender: UIButton) {
        let height = personalInformation.getHeight()! // get the height from the user setting
        bmiRecord!.weight = Double(weightTextField.text!)!
        bmiRecord!.date = datePicker.date
        let unit = personalInformation.getUnit()! // get the unit of the weight and height from the user setting
        var bmiScore = calculateBMI(height: height, weight: bmiRecord!.weight, unit: unit)
        // round the bmi score to 1 d.p.
        bmiRecord!.bmi = round(bmiScore * 10.0) / 10.0
        
        // update the bmi record on the list and update it in the persistent storage
        bmiRecordList.updateRecord(record: bmiRecord!)
        
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
