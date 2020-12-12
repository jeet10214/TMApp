//
//  Constants.swift
//  TMApp
//
//  Created by Jeet Kapadia on 12/12/20.
//

import Foundation

public enum ViewState: Equatable {
    case none
    case loading
    case errorWith(String)
    case content
}
