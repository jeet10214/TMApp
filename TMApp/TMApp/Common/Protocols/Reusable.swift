//
//  Reusable.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import Foundation
import UIKit

//MARK: Reusable
protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

//MARK: NibLoadable
protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

typealias NibReusable = Reusable & NibLoadable

extension NibLoadable where Self: UIView {
    static func loadFromNib(withOwner owner: Any? = nil) -> UIView {
        guard let view = nib.instantiate(withOwner: owner, options: nil).first as? UIView else {
            fatalError("the nib \(nib) is not found")
        }
        return view
    }
}

