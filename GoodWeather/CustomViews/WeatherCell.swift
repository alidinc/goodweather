//
//  WeatherCell.swift
//  GoodWeather
//
//  Created by Ali Dinç on 14/10/2021.
//

import Foundation
import UIKit

class WeatherCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var citynameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ vm: WeatherViewModel) {
        self.citynameLabel.text = vm.city
        self.temperatureLabel.text = "\(String(describing: vm.temperature.formatAsDegree()))"
    }
    
    
}
