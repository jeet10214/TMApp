//
//  TrendingMoviesInteractor.swift
//  TMApp
//
//  Created by Jeet Kapadia on 13/12/20.
//

import Foundation

final class TrendingMoviesInterator : TrendingMoviesInteractorInput {
    
    let network: NetworkAPIClient
    var presenter: TrendingMoviesInteractorOutput?
    
    init(network: NetworkAPIClient) {
        self.network = network
    }
    
    func loadMovies(for pageNum: Int) {
        
        let endPoint = MoviesAPI.getMoviesFor(page: pageNum)
        network.dataRequest(endPoint, objectType: TrendingMoviesBase.self) { [weak self] (result: Result<TrendingMoviesBase, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.getMoviesSuccess(response)
            case let .failure(error):
                self.presenter?.getMoviesError(error)
            }
        }
    }
}
