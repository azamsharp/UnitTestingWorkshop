//
//  CreditScoreResponse.swift
//  LoanApp
//
//  Created by Mohammad Azam on 4/21/24.
//

import Foundation

struct CreditScoreResponse: Decodable {
    let score: Int
    let lastUpdated: String
    let reportedBy: String
}
