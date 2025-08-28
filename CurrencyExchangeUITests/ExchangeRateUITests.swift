//
//  ExchangeRateUITests.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//


import XCTest

final class ExchangeRateUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testCurrencySearchAndSelection() {
        let searchField = app.textFields["Search country or currency..."]
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("euro")

        let euroCell = app.staticTexts["Euro (EUR)"]
        XCTAssertTrue(euroCell.waitForExistence(timeout: 2.0))
        euroCell.tap()
    }

    func testAmountEntryAndConversion() {
        let amountField = app.textFields["Amount"]
        XCTAssertTrue(amountField.exists)
        amountField.tap()
        amountField.clearAndEnterText("150")
        
        let euroField = app.textFields["Search country or currency..."]
        XCTAssertTrue(euroField.exists)
        euroField.tap()
        euroField.clearAndEnterText("Euro")

        let euroCell = app.staticTexts["Euro (EUR)"]
        euroCell.tap()

        let resultText = app.staticTexts["Result:"]
        XCTAssertTrue(resultText.waitForExistence(timeout: 5.0))
    }
}

extension XCUIElement {
    func clearAndEnterText(_ text: String) {
        guard let stringValue = value as? String else {
            XCTFail("Element has no text")
            return
        }
        tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
        typeText(text)
    }
}
