//
//  FontExtensions.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import Foundation
import UIKit

extension UIFont {
    convenience init(with name: APP_FONT_STYLE,of size: APP_FONT_SIZE) {
        self.init(name: name.rawValue,size: CGFloat(size.rawValue))!
    }
}
