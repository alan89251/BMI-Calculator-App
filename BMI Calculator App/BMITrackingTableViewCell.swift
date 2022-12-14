//
//  BMITrackingTableViewCell.swift
//  BMI Calculator App
//
//  Created by bee on 13/12/2022.
//

import UIKit

class BMITrackingTableViewCell: UITableViewCell {
    static let identifier: String = "BMITrackingTableViewCell"
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "BMITrackingTableViewCell", bundle: nil)
    }
    
    func configure(record: BMIRecord, row: Int) {
        weightLabel.text = String(record.weight)
        bmiLabel.text = String(record.bmi)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "ca")
        dateLabel.text = dateFormatter.string(from: record.date)
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
