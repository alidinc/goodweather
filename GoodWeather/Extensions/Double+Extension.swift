//
//  Double+Extension.swift
//  GoodWeather
//
//  Created by Ali Dinç on 15/10/2021.
//

import Foundation

extension Double {
    func formatAsDegree() -> String {
        return String(format: "%.0f°", self)
    }
}
