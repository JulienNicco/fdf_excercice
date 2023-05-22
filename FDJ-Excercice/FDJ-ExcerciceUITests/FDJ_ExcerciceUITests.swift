//
//  FDJ_ExcerciceUITests.swift
//  FDJ-ExcerciceUITests
//
//  Created by Julien Nicco on 12/05/2023.
//

import XCTest

final class FDJ_ExcerciceUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTeamDisplaying() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        Thread.sleep(forTimeInterval: 3)
        let searchBar = app.navigationBars["_TtGC7SwiftUI19UIHosting"].searchFields["League name"]
        searchBar.tap()
        searchBar.typeText("Ligue 1")
        app.scrollViews.otherElements.buttons["French Ligue 1"].tap()
        Thread.sleep(forTimeInterval: 3)
        XCTAssertTrue(app.images.element(boundBy: 0).exists, "First image not showing")
    }
}
