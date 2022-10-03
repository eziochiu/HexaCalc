//
//  HexaCalcUITests.swift
//  HexaCalcUITests
//
//  Created by Anthony Hopkins on 2022-09-24.
//  Copyright © 2022 Anthony Hopkins. All rights reserved.
//

import XCTest
import UIKit

class HexaCalcUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasicAppSetup() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Launched on Hexadecimal tab
        
        app.buttons["A"].tap()
        app.buttons["B"].tap()
                
        XCTAssert(assertResult(app: app, expected: "AB", calculator: 0))
        
        let tabBar = app.tabBars["Tab Bar"]
        
        tabBar.buttons["Binary"].tap()
                
        XCTAssert(assertResult(app: app, expected: "10101011", calculator: 1))
        
        app/*@START_MENU_TOKEN@*/.staticTexts["1"]/*[[".buttons[\"1\"].staticTexts[\"1\"]",".staticTexts[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        tabBar.buttons["Decimal"].tap()
        
        XCTAssert(assertResult(app: app, expected: "343", calculator: 2))
        
        app.buttons["9"].tap()
        
        tabBar.buttons["Settings"].tap()
        
        // App rating popup might appear
        if (app.scrollViews.otherElements.buttons["Not Now"].exists) {
            app.scrollViews.otherElements.buttons["Not Now"].tap()
        }
        
        tabBar.buttons["Hexadecimal"].tap()
        
        XCTAssert(assertResult(app: app, expected: "D6F", calculator: 0))
    }
    
    func testHexadecimalBasicCalculations() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let acButton = app.buttons["AC"]
        let divButton = app.buttons["÷"]
        let multButton = app.buttons["×"]
        let subButton = app.buttons["-"]
        let plusButton = app.buttons["+"]
        let equalsButton = app.buttons["="]
        
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        
        XCTAssert(assertResult(app: app, expected: "10", calculator: 0))
        
        // Addition
        plusButton.tap()
        
        app.buttons["3"].tap()
        app.buttons["2"].tap()
        
        XCTAssert(assertResult(app: app, expected: "32", calculator: 0))
        
        equalsButton.tap()
        
        XCTAssert(assertResult(app: app, expected: "42", calculator: 0))
        
        // Subtraction
        subButton.tap()
        
        app.buttons["3"].tap()
        app.buttons["0"].tap()
        
        XCTAssert(assertResult(app: app, expected: "30", calculator: 0))
        
        equalsButton.tap()
        
        XCTAssert(assertResult(app: app, expected: "12", calculator: 0))
        
        // Multiplication
        multButton.tap()
        
        app.buttons["F"].tap()
        app.buttons["E"].tap()
        
        XCTAssert(assertResult(app: app, expected: "FE", calculator: 0))
        
        equalsButton.tap()
        
        XCTAssert(assertResult(app: app, expected: "11DC", calculator: 0))
        
        // Division
        divButton.tap()
        
        app.buttons["A"].tap()
        app.buttons["B"].tap()
        
        XCTAssert(assertResult(app: app, expected: "AB", calculator: 0))
        
        equalsButton.tap()
        
        XCTAssert(assertResult(app: app, expected: "1A", calculator: 0))
        
        acButton.tap()
                
        XCTAssert(!app.staticTexts["1A"].exists)
    }
    
    func testBinaryBasicCalculations() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        
        tabBar.buttons["Binary"].tap()
        
        let acButton = app.buttons["AC"]
        let divButton = app.buttons["÷"]
        let multButton = app.buttons["×"]
        let subButton = app.buttons["-"]
        let plusButton = app.buttons["+"]
        let equalsButton = app.buttons["="]
        
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        
        XCTAssert(assertResult(app: app, expected: "10", calculator: 1))
        
        // Addition
        plusButton.tap()
        
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        
        XCTAssert(assertResult(app: app, expected: "10", calculator: 1))
        
        equalsButton.tap()
        
        XCTAssert(assertResult(app: app, expected: "100", calculator: 1))
        
        // Subtraction
        subButton.tap()
        
        app.buttons["1"].tap()
        
        XCTAssert(assertResult(app: app, expected: "1", calculator: 1))
        
        equalsButton.tap()
        
        XCTAssert(assertResult(app: app, expected: "11", calculator: 1))
        
        // Multiplication
        multButton.tap()
        
        app.buttons["1"].tap()
        app.buttons["1"].tap()
        
        XCTAssert(assertResult(app: app, expected: "11", calculator: 1))
        
        equalsButton.tap()
        
        XCTAssert(assertResult(app: app, expected: "1001", calculator: 1))
        
        // Division
        divButton.tap()
        
        app.buttons["1"].tap()
        app.buttons["1"].tap()
        
        XCTAssert(assertResult(app: app, expected: "11", calculator: 1))
        
        equalsButton.tap()
        
        XCTAssert(assertResult(app: app, expected: "11", calculator: 1))
        
        acButton.tap()
                
        XCTAssert(!app.buttons[formatBinaryString(stringToConvert: "11")].exists)
    }
    
    // Helper functions
    
    func assertResult(app: XCUIApplication, expected: String, calculator: Int) -> Bool {
        // Hexadecimal
        if calculator == 0 {
            return app.staticTexts[expected].label == expected
        }
        // Binary
        else if calculator == 1 {
            let text = formatBinaryString(stringToConvert: expected)
            return app.buttons[text].label == text
        }
        // Decimal
        else {
            return app.buttons[expected].label == expected
        }
    }
    
    func formatBinaryString(stringToConvert: String) -> String {
        var manipulatedStringToConvert = stringToConvert
        while (manipulatedStringToConvert.count < 64){
            manipulatedStringToConvert = "0" + manipulatedStringToConvert
        }
        return manipulatedStringToConvert.separate(every: 4, with: " ")
    }
}
