//
//  LoanAppTests.swift
//  LoanAppTests
//
//  Created by Mohammad Azam on 4/19/24.
//

import XCTest
@testable import LoanApp

final class LoanAppTests: XCTestCase {

    func testCalculateAPR() async throws {
      
        let aprService = APRService(httpClient: HTTPClient())
        let apr = try await aprService.calculateAPR(ssn: "345-34-2345")
        
        XCTAssertEqual(3.124, apr)
        
    }



}
