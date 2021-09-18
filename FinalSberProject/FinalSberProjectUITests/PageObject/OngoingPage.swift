//
//  OngoingPage.swift
//  FinalSberProjectUITests
//
//  Created by Виктор Поволоцкий on 13.09.2021.
//

import Foundation
import XCTest

class OngoingPage: Page {
    var app: XCUIApplication

    private var ongoingTableView: XCUIElement {
        return app.tables.element(matching: .table, identifier: "OngoingTable")
    }
    private var cellButton: XCUIElement {
        return ongoingTableView.cells.element(matching: .cell, identifier: "cell_0")
    }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func tapOnCellButton() -> CurrentMangaPage {
        if cellButton.waitForExistence(timeout: 30) {
            cellButton.forceTapElement()
        }
        return CurrentMangaPage(app: app)
    }
}

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            coordinate.tap()
        }
    }
}
