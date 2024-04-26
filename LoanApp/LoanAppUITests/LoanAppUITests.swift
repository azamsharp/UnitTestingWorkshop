//
//  LoanAppUITests.swift
//  LoanAppUITests
//
//  Created by Mohammad Azam on 4/24/24.
//

import XCTest

final class LoanAppUITests: XCTestCase {

    func testCalculateAPR() throws {
        
        let app = XCUIApplication()
        app.launchArguments = ["UITEST"]
        app.launch()
       
        let ssnTextField = app.textFields["ssnTextField"]
        ssnTextField.tap()
        ssnTextField.typeText("234-45-6655")
        
        // press the button
        let submitButton = app.buttons["submitButton"]
        submitButton.tap()
        
        let aprLabel = app.staticTexts["aprLabel"]
        let aprLabelExists = aprLabel.waitForExistence(timeout: 5.0)
        
        if aprLabelExists {
            XCTAssertEqual("3.124", aprLabel.label)
        } else {
            XCTFail("aprLabel does not exist after waiting")
        }
       
    }

}
