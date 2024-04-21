//
//  BudgetAppTests.swift
//  BudgetAppTests
//
//  Created by Mohammad Azam on 4/17/24.
//

import XCTest
import SwiftData
@testable import BudgetApp

// Twitter = @azamsharp
// Website = azamsharp.com
// Courses = azamsharp.school

final class BudgetAppTests: XCTestCase {

    // THIS TEST IS USELESS
    @MainActor
    func testBudgetCreate() throws {
        
        let container = try! ModelContainer(for: Budget.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = container.mainContext
        
        let budget = Budget(name: "Groceries", limit: 500)
        context.insert(budget)
        
        // retreive the budget
        let fetchDescriptor = FetchDescriptor<Budget>(predicate: #Predicate { $0.name == "Groceries" })
        let budgets: [Budget] = try context.fetch(fetchDescriptor)
        
        guard let savedBudget = budgets.first else {
            XCTFail("Unable to get the budget.")
            return
        }
        
        XCTAssertEqual("Groceries", savedBudget.name)
        XCTAssertEqual(500, savedBudget.limit)
    }
    
    @MainActor
    func testThrowDuplicateNameExceptionWhenSavingBudgetWithSameNameTwice() {
        
        let container = try! ModelContainer(for: Budget.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = container.mainContext
        
        let budget = Budget(name: "Groceries", limit: 500)
        context.insert(budget)
        
        // create another budget with same name
        let anotherBudget = Budget(name: "Groceries", limit: 250)
        
        XCTAssertThrowsError(try budget.save(context: context)) { error in
            let thrownError = error as? BudgetError
            XCTAssertNotNil(thrownError)
            XCTAssertEqual(BudgetError.duplicateName, thrownError)
        }
    }
    
    @MainActor
    func testCalculateBudgetExpensesTotal() throws {
        
        let container = try! ModelContainer(for: Budget.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = container.mainContext
        
        let budget = Budget(name: "Groceries", limit: 500)
        try budget.save(context: context)
        
        // create expenses
        let expenses = [Expense(name: "Milk", price: 4.50, quantity: 2), Expense(name: "Bread", price: 5, quantity: 10)]
        budget.expenses = expenses
        
        XCTAssertEqual(59, budget.spent)
    }
    
    @MainActor
    func testCalculateBudgetRemainingTotal() throws {
        
        let container = try! ModelContainer(for: Budget.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = container.mainContext
        
        let budget = Budget(name: "Groceries", limit: 500)
        try budget.save(context: context)
        
        // create expenses
        let expenses = [Expense(name: "Milk", price: 4.50, quantity: 2), Expense(name: "Bread", price: 5, quantity: 10)]
        budget.expenses = expenses
        XCTAssertEqual(441, budget.remaining)
    }

}
