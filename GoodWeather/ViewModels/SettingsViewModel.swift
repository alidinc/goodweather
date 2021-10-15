//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by Ali Dinç on 15/10/2021.
//

import Foundation

enum Unit: String, CaseIterable {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

extension Unit {
    var displayName: String {
        get {
            switch self {
            case .celsius:
                return "Celcius"
            case .fahrenheit:
                return "Fahrenheit"
            }
        }
    }
}

class SettingsViewModel {
    let userDefaults = UserDefaults.standard
    let units = Unit.allCases
    
    var selectedUnit: Unit {
        get {
            var unitValue = ""
            if let value = userDefaults.value(forKey: "unit") as? String {
                unitValue = value
            }
            return Unit(rawValue: unitValue) ?? Unit.celsius
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: "unit")
        }
    }
}

