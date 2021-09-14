//
//  OngoingPage.swift
//  FinalSberProjectUITests
//
//  Created by Виктор Поволоцкий on 13.09.2021.
//

import Foundation
import XCTest
@testable import FinalSberProject

class OngoingPage: Page {
    var app: XCUIApplication

    private var manhvaButton: XCUIElement { return app.buttons["manhvaButton"] }
    private var cellButton: XCUIElement { return app.tables.staticTexts["Поднятие уровня в одиночку"] }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func tapOnCellButton() -> CurrentMangaPage {
        manhvaButton.tap()
        cellButton.tap()
        return CurrentMangaPage(app: app)
    }
}
