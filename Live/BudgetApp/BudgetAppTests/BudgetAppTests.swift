//
//  BudgetAppTests.swift
//  BudgetAppTests
//
//  Created by Mohammad Azam on 4/27/24.
//

import XCTest
import SwiftData
@testable import BudgetApp

final class BudgetAppTests: XCTestCase {

    func testShouldBeAbleToInsertItemToAnArray() {
        
        var toys: [String] = []
        
        let item = "Toy"
        
        toys.append(item)
        
        XCTAssertTrue(toys.count == 1)
        
    }
    
    // A user can save a budget successfully
    @MainActor
    func testBudgetCreate() throws {
      
        let container = try! ModelContainer(for: Budget.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = container.mainContext
    
        let budget = Budget(name: "Groceries", limit: 500)
        context.insert(budget)
        
        // verify that the budget was saved successfully
        let fetchDescriptor = FetchDescriptor<Budget>(predicate: #Predicate<Budget> { $0.name == "Groceries" })
        let budgets = try context.fetch(fetchDescriptor)
        
        guard let savedBudget = budgets.first else {
            XCTFail("Unable to get the budget.")
            return
        }
        
        XCTAssertEqual("Groceries", savedBudget.name)
        XCTAssertEqual(500, savedBudget.limit)
    }
    
    // A user should not be able to add two budgets with the same name
    @MainActor
    func testThrowDuplicateNameExceptionWhenSavingBudgetWithSameNameTwice() {
        
        let container = try! ModelContainer(for: Budget.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let context = container.mainContext
        
        let budget = Budget(name: "Groceries", limit: 500)
        context.insert(budget)
        
        // create another budget with same name
        let anotherBudget = Budget(name: "Groceries", limit: 250)
        
        XCTAssertThrowsError(try anotherBudget.save(context: context)) { error in
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
        
        // testCalculateBudgetExpensesTotal(): XCTAssertEqual failed: ("59.0") is not equal to ("9.5")
        XCTAssertEqual(59, budget.spent)
    }
    
}
