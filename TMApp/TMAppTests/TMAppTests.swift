//
//  TMAppTests.swift
//  TMAppTests
//
//  Created by Jeet Kapadia on 12/12/20.
//

import XCTest
@testable import TMApp

class TrendingMoviesPresenterTests: XCTestCase {
    
    func testCaseOne(){
        let network: NetworkAPIClient = NetworkAPIClient()
        let expectation = XCTestExpectation.init(description: "Your expectation")
        
        // We ask the unit test to wait our expectation to finish.
        let endPoint = MoviesAPI.getMoviesFor(page: 1)
        network.dataRequest(endPoint, objectType: TrendingMoviesBase.self) { [weak self] (result: Result<TrendingMoviesBase, NetworkError>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                
                XCTAssertTrue(response.results?.count ?? 0 > 0)
                expectation.fulfill()
            case let .failure(error):
                XCTFail("Fail with error \(error)")
            }
            self.waitForExpectations(timeout: 20)
        }
    }
}
