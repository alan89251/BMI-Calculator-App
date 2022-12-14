//
//  BMITrackingTableViewCell.swift
//  BMI Calculator App
//
//  Created by bee on 13/12/2022.
//

import UIKit

protocol BMITrackingTableViewCellDelegate: AnyObject {
    func didDeleteBmiRecordAndTableViewCell(record: BMIRecord)
}

class BMITrackingTableViewCell: UITableViewCell {
    static let identifier: String = "BMITrackingTableViewCell"
    private var record: BMIRecord?
    weak var delegate: BMITrackingTableViewCellDelegate?
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "BMITrackingTableViewCell", bundle: nil)
    }
    
    /// configure the content of UIs of the cell
    func configure(record: BMIRecord, row: Int) {
        // save the record in the cell
        self.record = record
        
        // set the contents of the UIs
        weightLabel.text = String(record.weight)
        bmiLabel.text = String(record.bmi)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "ca")
        dateLabel.text = dateFormatter.string(from: record.date)
    }
    
    /// delegate to the table view controller to handle the actions of delete the BMI record
    @IBAction func btnDelete_onTouchUpInside(_ sender: UIButton) {
        delegate?.didDeleteBmiRecordAndTableViewCell(record: record!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
