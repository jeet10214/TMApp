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
        //TODO: Call API Here
        
    }
}
