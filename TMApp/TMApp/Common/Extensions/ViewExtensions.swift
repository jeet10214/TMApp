//
//  ViewExtensions.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import UIKit

extension UIView {
    func displaySpinner() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func hideSpinner() {
        guard let spinner = self.subviews.last as? UIActivityIndicatorView else { return }
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    func giveCorner(radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
