//
//  Expense.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 4/17/24.
//

import Foundation
import SwiftData

@Model
class Expense {
    
    var name: String
    var price: Double
    var quantity: Int
    
    var budget: Budget? 
    
    init(name: String, price: Double, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}
