//
//  MovieSimilarTests.swift
//  SampleMovieListTests
//
//  Created by Chandresh on 9/10/19.
//  Copyright © 2019 Chandresh. All rights reserved.
//

import XCTest
@testable import SampleMovieList

class MovieSimilarTests: XCTestCase {
    var viewModel: MovieDetailViewModel? = MovieDetailViewModel(networkManager: NetworkManager())
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertNotNil(viewModel?.movieDataResult)
        XCTAssertTrue((viewModel?.shouldLoadMoreData(totalPage: viewModel?.totalPages ?? 1,
                                                     totalPageLoaded: viewModel?.page ?? 1))!)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAsynchronousURLConnection() {
        let URL = "https://api.themoviedb.org/3/movie/475557/similar?api_key=fbf8e1eb83fef3170bdea6402982149c&page=1"
        let objExpectation: XCTestExpectation = expectation(description: "GET \(URL)")
        viewModel?.networkManager.getNowPlayingListData(page: viewModel?.page ?? 1, completion: { (data, error) in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            self.viewModel?.movieDataResult += data?.movieResults ?? self.viewModel!.movieDataResult
            XCTAssertTrue(((self.viewModel?.page +=  1) != nil))
            XCTAssertNotNil(self.viewModel?.movieDataResult, "Array Should not be nil")
            objExpectation.fulfill()
        })
        // put timeout as per your expectation
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    func testURLEncoding() {
        guard let url = URL(string: "https:www.google.com/") else {
            XCTAssertTrue(false, "Could not instantiate url")
            return
        }
        var urlRequest = URLRequest(url: url)
        let parameters: Parameters = [
            "UserID": 1,
            "Name": "Chandresh",
            "Email": "chandresh@gmail.com",
            "IsCool": true
        ]
        do {
            let encoder = URLParameterEncoder()
            try encoder.encode(urlRequest: &urlRequest, with: parameters)
            guard let fullURL = urlRequest.url else {
                XCTAssertTrue(false, "urlRequest url is nil.")
                return
            }
            let expectedURL = "https:www.google.com/?Name=Chandresh&Email=chandresh%2540gmail.com&UserID=1&IsCool=true"
            XCTAssertEqual(fullURL.absoluteString.sorted(), expectedURL.sorted())
        } catch {
            
        }
    }
}
