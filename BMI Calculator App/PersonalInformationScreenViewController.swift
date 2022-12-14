//
//  PersonalInformationScreenViewController.swift
//  BMI Calculator App
//
//  Created by bee on 13/12/2022.
//

import UIKit

class PersonalInformationScreenViewController: UIViewController {
    private var bmiRecordList: BMIRecordList!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bmiScoreLabel: UILabel!
    @IBOutlet weak var bmiDescriptionLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiRecordList = BMIRecordList.sharedBMIRecordList
    }
    
    @IBAction func btnDone_onTouchUpInside(_ sender: UIButton) {
        let unit = unitSegmentedControl.titleForSegment(at: unitSegmentedControl.selectedSegmentIndex)!
        let height = Double(heightTextField.text!)!
        let weight = Double(weightTextField.text!)!
        var bmiScore = calculateBMI(height: height, weight: weight, unit: unit)
        // round the bmi score to 1 d.p.
        bmiScore = round(bmiScore * 10.0) / 10.0
        
        // add the bmi record to the list and save it into the persistant storage
        bmiRecordList.addRecord(bmiRecord: BMIRecord(id: "",
                                                     weight: weight,
                                                     bmi: bmiScore,
                                                     date: Date.now) // use current date as the date of the record
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
