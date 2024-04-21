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

struct MockHTTPClient: HTTPClientProtocol {
    
    func getCreditScore(ssn: String) async throws -> Int? {
        
        if let path = Bundle.main.path(forResource: "credit-score-response", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path, relativeTo: nil))
                let result = try JSONDecoder().decode([String: Int].self, from: data)
                return result["score"]
            } catch {
                return nil
            }
        }
        
        return nil
    }
}

struct HTTPClient: HTTPClientProtocol {
    
    // THIS IS UNMANAGED DEPENDENCY
    func getCreditScore(ssn: String) async throws -> Int? {
        
        let url = URL(string: "https://island-bramble.glitch.me/api/credit-score/\(ssn)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let result = try JSONDecoder().decode([String: Int].self, from: data)
        
        // real HTTPClient
        return result["score"]
    }
}

struct APRService {
    
    private var httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func calculateAPR(ssn: String) async throws -> Double {
        
        let creditScore = try await httpClient.getCreditScore(ssn: ssn)
        
        
        if creditScore! > 650 {
            return 3.124
        } else {
            return 6.24
        }
        
    }
    
}

