//
//  TrendingMoviesProtocol.swift
//  TMApp
//
//  Created by Jeet Kapadia on 12/12/20.
//

import Foundation
import UIKit

//MARK: BaseInputView
protocol BaseViewInput : AnyObject{
    func displaySpinner()
    func hideSpinner()
}

extension BaseViewInput where Self: UIViewController {
    func displaySpinner(){
        
        view.displaySpinner()
    }
    
    func hideSpinner(){
        
        view.hideSpinner()
    }
}

//MARK:View
protocol TrendingMoviesViewInput: BaseViewInput {
    var presenter: TrendingMoviesViewOutput! { get set }
    func changeViewState(_ state: ViewState)
    func displayMovies(with viewModel: TrendingMoviesViewModel)
    func insertMovies(with viewModel: TrendingMoviesViewModel, at indexPaths: [IndexPath])
}

//MARK: Presenter
protocol TrendingMoviesModuleInput: AnyObject {
    var view: TrendingMoviesViewInput? { get set }
    var interactor: TrendingMoviesInteractorInput! { get set }
    var router: TrendingMoviesRouterInput! { get set }
}

protocol TrendingMoviesViewOutput: AnyObject {
    func getMovies()
    var isMoreDataAvailable: Bool { get }
    func didSelectMovie(at index: Int)
}

protocol TrendingMoviesInteractorOutput: AnyObject {
    func getMoviesSuccess(_ moviesBase: TrendingMoviesBase)
    func getMoviesError(_ error: NetworkError)
}

//MARK: InteractorInput
protocol TrendingMoviesInteractorInput: AnyObject {
    var presenter: TrendingMoviesInteractorOutput? { get set }
    func loadMovies(for pageNum: Int)
}

//MARK: Router
protocol TrendingMoviesRouterInput: AnyObject {
    func showMovieDetails(with movie: TrendingMovie)
}
