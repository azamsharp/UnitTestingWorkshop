//
//  LoanAppTests.swift
//  LoanAppTests
//
//  Created by Mohammad Azam on 4/19/24.
//

import XCTest
@testable import LoanApp

final class LoanAppTests: XCTestCase {
    
    func testCalculateAPRInvokesGetCreditScore() async throws {
        
        let expectation = XCTestExpectation(description: "Credit Score service was invoked.")
        var creditScoreService = MockedCreditScoreService()
        
        creditScoreService.onGetCreditScore = { ssn in
            expectation.fulfill()
            return 720
        }
        
        let aprService = APRService(creditScoreService: creditScoreService)
        let _ = try await aprService.calculateAPR(ssn: "345-34-2345")
        
        let result = await XCTWaiter().fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testCalculateAPR() async throws {
        
        let mockedCreditCardService = MockedCreditScoreService()
        
        let aprService = APRService(creditScoreService: mockedCreditCardService)
        let apr = try await aprService.calculateAPR(ssn: "345-45-3423")
        XCTAssertEqual(3.124, apr)

    }
    
    func testThrowExceptionWhenCreditScoreNotFound() async throws {
        
    }
}
