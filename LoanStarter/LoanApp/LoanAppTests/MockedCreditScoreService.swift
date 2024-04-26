//
//  MockedHTTPClient.swift
//  LoanAppTests
//
//  Created by Mohammad Azam on 4/21/24.
//

import Foundation
@testable import LoanApp

struct MockedCreditScoreService: CreditScoreServiceProtocol {
    
    func getCreditScore(ssn: String) async throws -> Int? {
        return nil
    }
}
