//
//  BMIRecord.swift
//  BMI Calculator App
//
//  Created by bee on 14/12/2022.
//

import Foundation

struct BMIRecord: Codable {
    internal var id: String
    var weight: Double
    var bmi: Double
    var date: Date
}
