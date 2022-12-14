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
        return cell
    }
}
