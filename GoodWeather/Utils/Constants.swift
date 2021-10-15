//
//  Constants.swift
//  GoodWeather
//
//  Created by Ali Dinç on 15/10/2021.
//

import Foundation

struct Constants {
    struct Urls {
        static func urlForWeatherByCity(city: String) -> URL {
            let userDefaults = UserDefaults.standard
            let unit = (userDefaults.value(forKey: "unit") as? String) ?? "imperial"
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=23200eaebcdb74727978506347ca77ab&units=\(unit)")!
        }
    }
}
