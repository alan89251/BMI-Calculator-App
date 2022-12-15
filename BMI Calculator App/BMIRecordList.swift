//
//  BMIRecordList.swift
//  BMI Calculator App
//  Author: Chun Fung Suen
//  Student ID: 301277969
//  Date: 15/12/2022
//  Changes: Implement the class to manage the bmi record list in memory and the persistent storage
//

import Foundation

/// Manage the bmi record list in memory and the persistent storage
class BMIRecordList {
    static let sharedBMIRecordList = BMIRecordList()
    private(set) var bmiRecords: [String: BMIRecord]
    
    /// load the bim records from UserDefaults (persistent storage)
    init() {
        bmiRecords = [:]
        let defaults = UserDefaults.standard
        if let data = defaults.value(forKey: "bmiRecords") as? Data,
           let storedBMIRecords = try? JSONDecoder().decode([String: BMIRecord].self, from: data) {
            bmiRecords = storedBMIRecords
        }
    }
    
    /// add a bmi record to the list and save it to the persistent storage
    func addRecord(bmiRecord: BMIRecord) {
        let newBmiRecord = BMIRecord(id: UUID().uuidString,
                                     weight: bmiRecord.weight,
                                     bmi: bmiRecord.bmi,
                                     date: bmiRecord.date)
        bmiRecords[newBmiRecord.id] = newBmiRecord
        saveBMIRecordList()
    }
    
    /// update the bmi record on the list and update it in the persistent storage
    func updateRecord(record: BMIRecord) {
        bmiRecords[record.id] = record
        saveBMIRecordList()
    }
    
    /// remove the bmi record from the list and delete it from the persistent storage
    func removeRecord(record: BMIRecord) {
        bmiRecords[record.id] = nil
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
    
    /// save the bmi record list to the persistent storage
    private func saveBMIRecordList() {
        if let encoded = try? JSONEncoder().encode(bmiRecords) {
            let defaults = UserDefaults.standard
            defaults.setValue(encoded, forKey: "bmiRecords")
            defaults.synchronize()
        }
    }
}
