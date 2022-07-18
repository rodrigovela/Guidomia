//
//  UIColor.swift
//  Guidomia
//
//  Created by Rodrigo Velazquez on 17/07/22.
//

import UIKit

extension UIColor {
    static let customOrange: UIColor = .init(rgb: 0xFC6016)
    static let customDarkGray: UIColor = .init(rgb: 0x858585)
    static let customLightGray: UIColor = .init(rgb: 0xD5D5D5)
}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
