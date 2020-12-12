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

enum Constants {
    static let defaultPageNum: Int = 0
    static let defaultTotalCount: Int = 0
    static let defaultPageSize: Int = 20
}

enum Strings {
    static let trendingMoviesTitle = "Trending Movies"
}
