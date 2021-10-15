//
//  WeatherResponse.swift
//  GoodWeather
//
//  Created by Ali Dinç on 15/10/2021.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: Weather
}

struct Weather: Codable {
    let temp: Double
    let humidity: Double
}
