//
//  BMIRecordList.swift
//  BMI Calculator App
//
//  Created by bee on 14/12/2022.
//

import Foundation

/// Manage the bmi record list in memory and the persistant storage
class BMIRecordList {
    static let sharedBMIRecordList = BMIRecordList()
    private(set) var bmiRecords: [String: BMIRecord]
    
    /// load the bim records from UserDefaults (persistant storage)
    init() {
        bmiRecords = [:]
        let defaults = UserDefaults.standard
        if let data = defaults.value(forKey: "bmiRecords") as? Data,
           let storedBMIRecords = try? JSONDecoder().decode([String: BMIRecord].self, from: data) {
            bmiRecords = storedBMIRecords
        }
    }
    
    /// add a bmi record to the list and save it to the persistant storage
    func addBMIRecord(bmiRecord: BMIRecord) {
        let newBmiRecord = BMIRecord(id: UUID().uuidString,
                                     weight: bmiRecord.weight,
                                     bmi: bmiRecord.bmi,
                                     date: bmiRecord.date)
        bmiRecords[newBmiRecord.id] = newBmiRecord
        saveBMIRecordList()
    }
    
    /// get all the bmi records in an array
    func getAllRecords() -> [BMIRecord] {
        return Array(bmiRecords.values)
    }
    
    /// return the number of bmi records in the list
    func count() -> Int {
        return bmiRecords.count
    }
    
    /// save the bmi record list to the persistant storage
    private func saveBMIRecordList() {
        if let encoded = try? JSONEncoder().encode(bmiRecords) {
            let defaults = UserDefaults.standard
            defaults.setValue(encoded, forKey: "bmiRecords")
            defaults.synchronize()
        }
    }
}
