//
//  BMIRecord.swift
//  BMI Calculator App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 15/12/2022
//  Changes: Implement the data structure for bmi record
//

import Foundation

/// data structure for bmi record
struct BMIRecord: Codable {
    internal var id: String
    var weight: Double
    var bmi: Double
    var date: Date
}
