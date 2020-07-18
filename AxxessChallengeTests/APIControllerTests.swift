//
//  APIControllerTests.swift
//  AxxessChallengeTests
//
//  Created by Nabil Kazi on 18/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import XCTest
@testable import AxxessChallenge

class APIControllerTests: XCTestCase {

    var apiController: APIDataController!
    
    override func setUp() {
        super.setUp()
        apiController = APIDataController()
    }
    
    override func tearDown() {
        apiController = nil
        super.tearDown()
    }

    func test_getTrendingMovies() {
        let testExpectation = expectation(description: "fetchData function should not return an error")
        
        apiController.fetchData{_, error in
            XCTAssertNil(error)
            testExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
