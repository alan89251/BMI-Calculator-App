//
//  BMITrackingScreenTableViewController.swift
//  BMI Calculator App
//
//  Created by bee on 13/12/2022.
//

import UIKit

class BMITrackingScreenTableViewController: UITableViewController {
    private var bmiRecordList: BMIRecordList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiRecordList = BMIRecordList.sharedBMIRecordList
        
        tableView.register(BMITrackingTableViewCell.nib(), forCellReuseIdentifier: BMITrackingTableViewCell.identifier)
        tableView.dataSource = self
        tableView.rowHeight = 120
    }
    
    // reload and update the bmi record list every time when the view is switched to
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    /// navigate to the add bmi record screen
    @IBAction func btnAdd_onClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toVC = storyboard.instantiateViewController(withIdentifier: "AddBmiRecord") as! AddBmiRecordViewController
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bmiRecordList.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = bmiRecordList.getAllRecords()
        let cell = tableView.dequeueReusableCell(withIdentifier: BMITrackingTableViewCell.identifier, for: indexPath) as! BMITrackingTableViewCell
        cell.configure(record: data[indexPath.row], row: indexPath.row)
        cell.delegate = self
        return cell
    }
}

extension BMITrackingScreenTableViewController: BMITrackingTableViewCellDelegate {
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
