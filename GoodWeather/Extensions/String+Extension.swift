//
//  String+Extension.swift
//  GoodWeather
//
//  Created by Ali Dinç on 15/10/2021.
//

import Foundation

extension String {
    func escaped() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
