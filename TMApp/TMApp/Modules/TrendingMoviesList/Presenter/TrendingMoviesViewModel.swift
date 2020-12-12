//
//  TrendingMoviesViewModel.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import Foundation

struct TrendingMoviesViewModel {
    
    var trendingMovies : [TrendingMovie] = []
    
    init(_trendingMovies : [TrendingMovie]) {
        trendingMovies = _trendingMovies
    }
    
    var isEmpty : Bool {
        return trendingMovies.isEmpty
    }
    
    var trendingMoviesCount: Int {
        return trendingMovies.count
    }
    
    mutating func addMoreTrendingMovies(_ _trendingMovies: [TrendingMovie]){
        trendingMovies += _trendingMovies
    }
}

extension TrendingMoviesViewModel {
    
    func trendingMovieAt(_ index: Int) -> TrendingMovie {
        guard !trendingMovies.isEmpty else {
            fatalError("No more movies available")
        }
        return trendingMovies[index]
    }
    
    func posterURL(_ index: Int) -> URL? {
        guard !trendingMovies.isEmpty else {
            fatalError("No more movies available")
        }
        guard let path = trendingMovies[index].poster_path, let url = URL(string: APIConstants.moviesImagesBaseURL + path) else {
            return nil
        }
        return url
    }
}
