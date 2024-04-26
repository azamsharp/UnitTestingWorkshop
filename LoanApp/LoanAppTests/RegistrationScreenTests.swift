//
//  RegistrationScreenTests.swift
//  LoanAppTests
//
//  Created by Mohammad Azam on 4/26/24.
//

import XCTest
@testable import LoanApp

final class RegistrationScreenTests: XCTestCase {
    
    func testRegistrationFormValid() {
        
        let testData = [
            ("Mohammad", "Azam", "123-45-6789"),
            ("John", "Doe", "987-65-4321"),
            ("Jane", "Smith", "111-22-3333")
        ]
        
        for (firstName, lastName, ssn) in testData {
            let registrationForm = RegistrationForm(firstName: firstName, lastName: lastName, ssn: ssn)
            XCTAssertTrue(registrationForm.isValid, "\(firstName) \(lastName) with SSN \(ssn) should be valid")
        }
        
    }
    
    func testRegistrationFormInvalid() {
        
        let invalidData = [
            ("", "Doe", "123-45-6789"),
            ("John", "", "123-45-6789"),
            ("Jane", "Smith", "123456789"),
            ("Jane", "Smith", "abc-def-ghij")
        ]
        
        for (firstName, lastName, ssn) in invalidData {
            let registrationForm = RegistrationForm(firstName: firstName, lastName: lastName, ssn: ssn)
            XCTAssertFalse(registrationForm.isValid, "\(firstName) \(lastName) with SSN \(ssn) should be invalid")
        }
    }
    
    func testIsSSN() {
        
        let validSSNs = ["123-45-6789", "987-65-4321", "111-22-3333"]
        let invalidSSNs = ["", "123", "123456789", "abc-def-ghij", "123-45-67890", "12-34-5678", "123-456-789", "123--4567"]
        
        for ssn in validSSNs {
            XCTAssertTrue(ssn.isSSN)
        }
        
        for ssn in invalidSSNs {
            XCTAssertFalse(ssn.isSSN)
        }
        
    }
    
    // write tests for isEmptyOrWhitespace property
    
}
