//
//  APRService.swift
//  LoanApp
//
//  Created by Mohammad Azam on 4/19/24.
//

import Foundation



protocol HTTPClientProtocol {
    func getCreditScore(ssn: String) async throws -> Int?
}

struct HTTPClient: HTTPClientProtocol {
    
    // THIS IS UNMANAGED DEPENDENCY
    func getCreditScore(ssn: String) async throws -> Int? {
        
        let url = URL(string: "https://island-bramble.glitch.me/api/credit-score/\(ssn)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result = try JSONDecoder().decode(CreditScoreResponse.self, from: data)
        
        // real HTTPClient
        return result.score 
    }
}

struct APRService {
    
    private var httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func calculateAPR(ssn: String) async throws -> Double {
        
        guard let creditScore = try await httpClient.getCreditScore(ssn: ssn) else {
            throw CreditScoreError.noCreditScoreFound
        }
        
        if creditScore > 650 {
            return 3.124
        } else {
            return 6.24
        }
        
    }
    
}

