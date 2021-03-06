//
//  FinalSberProjectUITests.swift
//  FinalSberProjectUITests
//
//  Created by Виктор Поволоцкий on 16.08.2021.
//

import XCTest
import SnapshotTesting
@testable import MangaRead

class FinalSberProjectUITests: XCTestCase {

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        let ongoingsPage = OngoingPage(app: app)
        ongoingsPage
            .tapOnCellButton()
            .tapOnDescriptionButton()
            .checkDescriptionOnExist(then: {
                XCTAssertEqual($0, true)
                print("correct work")
            })
    }

}
