//
//  BMITrackingScreenTableViewController.swift
//  BMI Calculator App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 15/12/2022
//  Changes: Implement the logic for the UI controls
//

import UIKit

/// Manage the logic of the BMI Tracking Screen
class BMITrackingScreenTableViewController: UITableViewController {
    private var bmiRecordList: BMIRecordList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiRecordList = BMIRecordList.sharedBMIRecordList
        
        tableView.register(BMITrackingTableViewCell.nib(), forCellReuseIdentifier: BMITrackingTableViewCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = 68
    }
    
    /// reload and update the bmi record list every time when the view is switched to
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    /// navigate to the add bmi record screen
    @IBAction func btnAdd_onClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toVC = storyboard.instantiateViewController(withIdentifier: "AddBmiRecord") as! AddBmiRecordViewController
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    // MARK: - Table view data source

    /// return the number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    /// return the number of rows in the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bmiRecordList.count()
    }
    
    /// create a table cell for the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = bmiRecordList.getAllRecords()
        let cell = tableView.dequeueReusableCell(withIdentifier: BMITrackingTableViewCell.identifier, for: indexPath) as! BMITrackingTableViewCell
        cell.configure(record: data[indexPath.row], row: indexPath.row) // configure the cell by the bmi record
        cell.delegate = self
        return cell
    }
}

extension BMITrackingScreenTableViewController: BMITrackingTableViewCellDelegate {
    /// handle the actions of update the BMI record
    func didUpdateBmiRecordAndTableViewCell(record: BMIRecord) {
        // navigate to the update bmi record screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toVC = storyboard.instantiateViewController(withIdentifier: "UpdateBmiRecord") as! UpdateBmiRecordViewController
        toVC.setBmiRecord(bmiRecord: record)
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    /// handle the actions of delete the BMI record
    func didDeleteBmiRecordAndTableViewCell(record: BMIRecord) {
        bmiRecordList.removeRecord(record: record) // delete the BMI record from the list and the persistant storage
        
        // if all the records on the list are deleted, navigate to the personal information screen
        if (bmiRecordList.count() == 0) {
            self.tabBarController?.selectedIndex = 0
        }
        else {
            tableView.reloadData() // reload the table view to remove the table view cell of the record from the table view
        }
    }
}
