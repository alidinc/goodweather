//
//  UIView+Extension.swift
//  GoodWeather
//
//  Created by Ali Dinç on 14/10/2021.
//

import UIKit

extension UIView {
    func addShadow(xAxis: CGFloat, yAxis: CGFloat, shadowRadius: CGFloat, color: UIColor, shadowOpacity: Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = shadowRadius  // 6-8
        self.layer.shadowOpacity = shadowOpacity //0.12
        self.layer.shadowOffset = CGSize(width: xAxis, height: yAxis) // x = 0 , y = 4
    }
}
