//
//  MoviesAPI.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import Foundation

enum MoviesAPI: APIEndPoint, URLRequestConvertible {
    
    case getMoviesFor(page: Int)
}

extension MoviesAPI {
    var baseURL: URL {
        return URL(string: APIConstants.moviesAPIBaseURL)!
    }
    
    var method: HTTPMethod {
        return .get
    }

    var shouldCache: Bool {
        return false
    }
    
    var path: String {
        switch self {
        case .getMoviesFor:
            return "/3/trending/movie/week"
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case let .getMoviesFor(page):
            return [
                "api_key": APIConstants.moviesAPIKey,
                "language": "en-US",
                "page": page
            ]
        }
    }
}

//MARK: NetworkAPI Constants
enum APIConstants {
    static let moviesAPIBaseURL = "https://api.themoviedb.org"
    static let moviesImagesBaseURL = "https://image.tmdb.org/t/p/w300"
    static let moviesAPIKey = "8eac22f4c24d01c480e4d99fef2edfc3"
}
