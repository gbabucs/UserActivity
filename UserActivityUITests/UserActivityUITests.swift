//
//  UserActivityUITests.swift
//  UserActivityUITests
//
//  Created by ThunderFlash on 05/08/2019.
//  Copyright © 2019 system. All rights reserved.
//

import XCTest

class UserActivityUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigationOfSingleUser() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        //tablesQuery.staticTexts["Karianne"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Douglas Extension, Suite 847, McKenziehaven, 59590-4157"]/*[[".cells.staticTexts[\"Douglas Extension, Suite 847, McKenziehaven, 59590-4157\"]",".staticTexts[\"Douglas Extension, Suite 847, McKenziehaven, 59590-4157\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        addUIInterruptionMonitor(withDescription: "Allow “UserActivity” to access your location?") { (alert) -> Bool in
            let button = alert.buttons["Only While Using the App"]
            if button.exists {
                button.tap()
                return true
            }
            
            return false
        }
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["User Information"].tap()
        tabBarsQuery.buttons["Post"].tap()
        app.navigationBars["Posts"].buttons["Close"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Kamren"]/*[[".cells.staticTexts[\"Kamren\"]",".staticTexts[\"Kamren\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Show Album"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["molestiae voluptate non"]/*[[".cells.staticTexts[\"molestiae voluptate non\"]",".staticTexts[\"molestiae voluptate non\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Photos"].buttons["Album List"].tap()
    }

}
