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
            XCTAssertEqual(ssn, "345-34-2345", "Expected SSN to be 345-34-2345")
            expectation.fulfill()
            return 720
        }
        
        let aprService = APRService(creditScoreService: creditScoreService)
        let _ = try await aprService.calculateAPR(ssn: "345-34-2345")
        
        let result = await XCTWaiter().fulfillment(of: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
    }
    
    func testCalculateAPR() async throws {
        
        var creditScoreService = MockedCreditScoreService()
        
        creditScoreService.onGetCreditScore = { ssn in
            return 720
        }
        
        let aprService = APRService(creditScoreService: creditScoreService)
        let apr = try await aprService.calculateAPR(ssn: "345-34-2345")
        XCTAssertEqual(3.124, apr)
        
    }
    
    func testThrowExceptionWhenCreditScoreNotFound() async throws {
        
        let aprService = APRService(creditScoreService: MockedCreditScoreService())
        
        do {
            let apr = try await aprService.calculateAPR(ssn: "444-44-4444")
            XCTFail("Expected an error to be thrown, but received \(apr) instead.")
        } catch {
            XCTAssertEqual(CreditScoreError.noCreditScoreFound, error as? CreditScoreError)
        }
    }
}
