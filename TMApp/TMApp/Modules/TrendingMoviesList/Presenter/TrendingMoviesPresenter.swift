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
    
    var trendingMoviesViewModel: TrendingMoviesViewModel!
    
    var pageNum = Constants.defaultPageNum
    var totalCount = Constants.defaultTotalCount
    var totalPages = Constants.defaultPageNum
    
    var isMoreDataAvailable: Bool{
        guard totalPages != 0 else {
            return true
        }
        return pageNum < totalPages
    }
    
    //MARK: TrendingMoviesViewOutput
    
    func getMovies() {
        guard isMoreDataAvailable else {
            view?.changeViewState(.content)
            return
        }
        view?.changeViewState(.loading)
        pageNum += 1
        interactor.loadMovies(for: pageNum)
    }
    
    func didSelectMovie(at index: Int) {
        
    }
    
    func getMoviesSuccess(_ moviesBase: TrendingMoviesBase) {
        guard let movies = moviesBase.results else { return }
        
        if totalCount == Constants.defaultTotalCount {
            trendingMoviesViewModel = TrendingMoviesViewModel(_trendingMovies: movies)
            totalCount = movies.count
            
            if let _totalPages = moviesBase.total_pages {
                totalPages = _totalPages
            }

            DispatchQueue.main.async { [unowned self] in
                self.view?.displayMovies(with: self.trendingMoviesViewModel)
                self.view?.changeViewState(.content)
            }
        } 
    }
    
    func getMoviesError(_ error: NetworkError) {
        DispatchQueue.main.async {
            self.view?.changeViewState(.errorWith(error.description))
        }
    }
    
    fileprivate func insertMoreMovies(with movies: [TrendingMovie]) {
        let previousCount = totalCount
        totalCount += movies.count
        trendingMoviesViewModel.addMoreTrendingMovies(movies)
        let indexPaths: [IndexPath] = (previousCount..<totalCount).map {
            return IndexPath(item: $0, section: 0)
        }
        DispatchQueue.main.async { [unowned self] in
            self.view?.insertMovies(with: self.trendingMoviesViewModel, at: indexPaths)
            self.view?.changeViewState(.content)
        }
    }
}
