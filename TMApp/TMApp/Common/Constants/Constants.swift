//
//  Constants.swift
//  TMApp
//
//  Created by Jeet Kapadia on 12/12/20.
//

import Foundation
import UIKit

public enum ViewState: Equatable {
    case none
    case loading
    case errorWith(String)
    case content
}

enum Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let defaultPageNum: Int = 0
    static let defaultTotalCount: Int = 0
    static let defaultPageSize: Int = 20
    static let defaultSpacing: CGFloat = 1
    static let numberOfColumns: CGFloat = 2 
    static let defaultPadding: CGFloat = 8
    static let defaultRadius: CGFloat = 10
}

enum Strings {
    static let trendingMoviesTitle = "Trending Movies"
    
    static let cancel = "Cancel"
    static let ok = "Ok"
    static let retry = "Retry"
    static let error = "Error"
}

enum APP_FONT_STYLE: String {
    case LIGHT      = "HelveticaNeue-Light"
    case REGULAR    = "HelveticaNeue"
    case MEDIUM     = "HelveticaNeue-Medium"
    case BOLD       = "HelveticaNeue-Bold"
}

enum APP_FONT_SIZE: Float {
    case TITLE      = 20
    case DEFAULT    = 17
    case SUB_TITLE  = 14
    case SMALL      = 12
}

enum APP_IMAGES: String {
    case SEARCH = "Search"
    case STAR = "Star"
    case REEL = "Reel"
}

enum APP_COLOR: String {
    case SUB_THEME = "70c295"
    case THEME = "3ca5dd"
}
