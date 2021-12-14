//
//  SearchUITests.swift
//  PlanetariumApplicationUITests
//
//  Created by Mikael Holm on 10.12.2021.
//

import XCTest

class SearchUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testFormIsReset() {
        let searchTab = app.tabBars.buttons.element(boundBy: 1)
        XCTAssertTrue(searchTab.exists)
        searchTab.tap()
        
        let startDate = app.datePickers["startDate"]
        XCTAssertTrue(startDate.exists)
        
        let endDate = app.datePickers["endDate"]
        XCTAssertTrue(endDate.exists)
        
        let amountOfPicturesField = app.textFields["amountOfPicturesField"]
        XCTAssertTrue(amountOfPicturesField.exists)
        amountOfPicturesField.tap()
        amountOfPicturesField.typeText("10")
        
        let resetButton = app.buttons["resetButton"]
        XCTAssertTrue(resetButton.exists)
        resetButton.tap()
        
        XCTAssertEqual("", amountOfPicturesField.label)
    }
    
    func testSearchResultsFromRandomPictures() {
        let searchTab = app.tabBars.buttons.element(boundBy: 1)
        XCTAssertTrue(searchTab.exists)
        searchTab.tap()
        
        let amountOfPicturesField = app.textFields["amountOfPicturesField"]
        XCTAssertTrue(amountOfPicturesField.exists)
        amountOfPicturesField.tap()
        amountOfPicturesField.typeText("10")
        
        let searchButton = app.buttons["searchButton"]
        XCTAssertTrue(searchButton.exists)
        searchButton.tap()
        
        let results = app.tables.firstMatch
        XCTAssertTrue(results.exists)
        let cell = results.cells.element(boundBy: 0)
        let predicate = NSPredicate(format: "exists == 1")
        expectation(for: predicate, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(10, results.cells.count)
        cell.tap()
        
        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.exists)
        backButton.tap()
    }
}
