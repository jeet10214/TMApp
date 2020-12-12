//
//  TrendingMoviesPresenter.swift
//  TMApp
//
//  Created by Jeet Kapadia on 12/12/20.
//

import Foundation

final class TrendingMoviesPresenter: TrendingMoviesModuleInput, TrendingMoviesViewOutput, TrendingMoviesInteractorOutput {
    
    weak var view: TrendingMoviesViewInput?
    
    var interactor: TrendingMoviesInteractorInput!
    
    var router: TrendingMoviesRouterInput!
    
    func getMovies() {
        
    }
    
    var isMoreDataAvailable: Bool{
        return true
    }
    
    func didSelectMovie(at index: Int) {
        
    }
    
    func getMoviesSuccess(_ moviesBase: TrendingMoviesBase) {
        
    }
    
    func getMoviesError(_ error: NetworkError) {
        
    }
}
