//
//  MockedHTTPClient.swift
//  LoanApp
//
//  Created by Mohammad Azam on 4/24/24.
//

import Foundation

struct MockedCreditScoreService: CreditScoreServiceProtocol {
    
    func getCreditScore(ssn: String) async throws -> Int? {
        return 200
    }
}
