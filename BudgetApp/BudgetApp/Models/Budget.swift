//
//  Budget.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 4/17/24.
//

import Foundation
import SwiftData

enum BudgetError: Error {
    case duplicateName
}

@Model
class Budget {
    
    var name: String
    var limit: Double
    @Relationship(deleteRule: .cascade)
    var expenses: [Expense] = []
    
    init(name: String, limit: Double) {
        self.name = name
        self.limit = limit
    }
    
    var spent: Double {
        expenses.reduce(0) { result, expense in
            result + (expense.price * Double(expense.quantity))
        }
    }
    
    var remaining: Double {
        limit - spent 
    }
    
    private func budgetExists(_ name: String, _ context: ModelContext) -> Bool {
        let fetchDescriptor = FetchDescriptor<Budget>(predicate: #Predicate<Budget> { $0.name == name })
        guard let budgets = try? context.fetch(fetchDescriptor) else { return false }
        return !budgets.isEmpty && budgets.count == 1
    }
    
    func save(context: ModelContext) throws {
        
        if budgetExists(name, context) {
            throw BudgetError.duplicateName
        }
        
        context.insert(self)
    }
}
