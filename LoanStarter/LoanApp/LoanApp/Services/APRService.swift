//
//  APRService.swift
//  LoanApp
//
//  Created by Mohammad Azam on 4/19/24.
//

import Foundation

protocol CreditScoreServiceProtocol {
    func getCreditScore(ssn: String) async throws -> Int?
}

struct CreditScoreService: CreditScoreServiceProtocol {
    
    let baseURL: URL
    
    // THIS IS UNMANAGED DEPENDENCY THIS IS THE TEST URL PROVIDED BY THE CREDIT SCORE COMPANY
    func getCreditScore(ssn: String) async throws -> Int? {
        
        var url = baseURL
        url.append(path: "/api/credit-score/\(ssn)")
        
        //let url = URL(string: "https://island-bramble.glitch.me/api/credit-score/\(ssn)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result = try JSONDecoder().decode(CreditScoreResponse.self, from: data)
        
        // real HTTPClient
        return result.score 
    }
}

// our own service
struct APRService {
    
    // third party service
    private var creditScoreService: CreditScoreServiceProtocol
    
    init(creditScoreService: CreditScoreServiceProtocol) {
        self.creditScoreService = creditScoreService
    }
    
    func calculateAPR(ssn: String) async throws -> Double {
        
        guard let creditScore = try await creditScoreService.getCreditScore(ssn: ssn) else {
            throw CreditScoreError.noCreditScoreFound
        }
        
        if creditScore > 650 {
            return 3.124
        } else {
            return 6.24
        }
        
    }
    
}

