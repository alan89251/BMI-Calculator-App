//
//  PersonalInformation.swift
//  BMI Calculator App
//
//  Created by bee on 14/12/2022.
//

import Foundation

/// Manage the personal information screen 's settings in the memory and the persistent storage
class PersonalInformationScreenSetting {
    static let sharedPersonalInformationScreenSetting = PersonalInformationScreenSetting()
    
    private static let nameKey = "name" // key used in storage
    private static let ageKey = "age" // key used in storage
    private static let genderKey = "gender" // key used in storage
    private static let heightKey = "height" // key used in storage
    private static let weightKey = "weight" // key used in storage
    private static let unitKey = "unit" // key used in storage
    
    private var name: String?
    private var age: Int?
    private var gender: String?
    private var height: Double?
    private var weight: Double?
    private var unit: String?
    
    /// load personal information screen 's settings from the persistent storage
    init() {
        name = UserDefaults.standard.string(forKey: PersonalInformationScreenSetting.nameKey)
        age = UserDefaults.standard.integer(forKey: PersonalInformationScreenSetting.ageKey)
        gender = UserDefaults.standard.string(forKey: PersonalInformationScreenSetting.genderKey)
        height = UserDefaults.standard.double(forKey: PersonalInformationScreenSetting.heightKey)
        weight = UserDefaults.standard.double(forKey: PersonalInformationScreenSetting.weightKey)
        unit = UserDefaults.standard.string(forKey: PersonalInformationScreenSetting.unitKey)
    }
    
    func getName() -> String? {
        return name
    }
    
    func getAge() -> Int? {
        return age
    }
    
    func getGender() -> String? {
        return gender
    }
    
    func getHeight() -> Double? {
        return height
    }
    
    func getWeight() -> Double? {
        return weight
    }
    
    func getUnit() -> String? {
        return unit
    }
    
    /// set the value and also save to the persistent storage
    func setName(name: String) {
        self.name = name
        UserDefaults.standard.set(self.name, forKey: PersonalInformationScreenSetting.nameKey)
        UserDefaults.standard.synchronize()
    }
    
    /// set the value and also save to the persistent storage
    func setAge(age: Int) {
        self.age = age
        UserDefaults.standard.set(self.age, forKey: PersonalInformationScreenSetting.ageKey)
        UserDefaults.standard.synchronize()
    }
    
    /// set the value and also save to the persistent storage
    func setGender(gender: String) {
        self.gender = gender
        UserDefaults.standard.set(self.gender, forKey: PersonalInformationScreenSetting.genderKey)
        UserDefaults.standard.synchronize()
    }
    
    /// set the value and also save to the persistent storage
    func setHeight(height: Double) {
        self.height = height
        UserDefaults.standard.set(self.height, forKey: PersonalInformationScreenSetting.heightKey)
        UserDefaults.standard.synchronize()
    }
    
    /// set the value and also save to the persistent storage
    func setWeight(weight: Double) {
        self.weight = weight
        UserDefaults.standard.set(self.weight, forKey: PersonalInformationScreenSetting.weightKey)
        UserDefaults.standard.synchronize()
    }
    
    /// set the value and also save to the persistent storage
    func setUnit(unit: String) {
        self.unit = unit
        UserDefaults.standard.set(self.unit, forKey: PersonalInformationScreenSetting.unitKey)
        UserDefaults.standard.synchronize()
    }
}
