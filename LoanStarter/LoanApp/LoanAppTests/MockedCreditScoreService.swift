//
//  MockedHTTPClient.swift
//  LoanAppTests
//
//  Created by Mohammad Azam on 4/21/24.
//

import Foundation
@testable import LoanApp

struct MockedCreditScoreService: CreditScoreServiceProtocol {
    
    let ssnsWithNoCreditScores = ["444-44-4444", "222-22-2222"]
    
    var onGetCreditScore: ((String) -> Int?)?
    
    func getCreditScore(ssn: String) async throws -> Int? {
        
        if ssnsWithNoCreditScores.contains(ssn) {
            return nil
        }
        
        //return 720
        
        return onGetCreditScore?(ssn)
    }
}



