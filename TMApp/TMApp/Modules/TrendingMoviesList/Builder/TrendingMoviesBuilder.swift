//
//  TrendingMoviesBuilder.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import Foundation

protocol TrendingMoviesModuleBuilderProtocol: AnyObject {
    func buildModule() -> TrendingMoviesVC
}

final class TrendingMoviesModuleBuilder : TrendingMoviesModuleBuilderProtocol {
    
    func buildModule() -> TrendingMoviesVC {
        let moviesVC = TrendingMoviesVC()
        let presenter = TrendingMoviesPresenter()
        let network = NetworkAPIClient()
        let interactor = TrendingMoviesInterator(network: network)
        let router = TrendingMoviesRouter()
        
        presenter.view = moviesVC
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        moviesVC.presenter = presenter
        router.viewController = moviesVC
        
        return moviesVC
    }
}
