//
//  MockedHTTPClient.swift
//  LoanAppTests
//
//  Created by Mohammad Azam on 4/21/24.
//

import Foundation
@testable import LoanApp

struct MockHTTPClient: HTTPClientProtocol {
    
    var onGetCreditScore: ((String) -> Int?)?
    
    let ssnsWithNoCreditScores = ["444-44-4444", "222-22-2222"]
    
    func getCreditScore(ssn: String) async throws -> Int? {
        
        if ssnsWithNoCreditScores.contains(ssn) {
            return nil
        }
        
        if let path = Bundle(for: LoanAppTests.self).path(forResource: "credit-score-response", ofType: "json") {
            do {
                
                let data = try Data(contentsOf: URL(filePath: path))
                // decode
                let creditScoreResponse = try JSONDecoder().decode(CreditScoreResponse.self, from: data)
                return onGetCreditScore?(ssn)
            } catch {
                print(error)
                return nil
            }
        }
        
        return nil
    }
}
