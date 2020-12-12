//
//  UIColorExtensions.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import UIKit

extension UIColor {
    static func appBackground() -> UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        }
        else { return .white }
    }
}
