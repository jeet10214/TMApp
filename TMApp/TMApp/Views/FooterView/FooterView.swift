//
//  FooterView.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import Foundation
import UIKit

final class FooterView: UICollectionReusableView, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) not implemented")
    }
    
    private func setup() {
        displaySpinner()
    }
}
