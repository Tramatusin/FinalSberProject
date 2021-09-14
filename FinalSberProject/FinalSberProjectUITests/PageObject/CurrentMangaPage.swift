//
//  CurrentMangaPage.swift
//  FinalSberProjectUITests
//
//  Created by Виктор Поволоцкий on 13.09.2021.
//

import Foundation
import XCTest

class CurrentMangaPage: Page {
    var app: XCUIApplication

    private var descriptionButton: XCUIElement { return app.staticTexts["Описание"] }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func tapOnDescriptionButton() -> DescriptionPage {
        descriptionButton.tap()
        return DescriptionPage(app: app)
    }
}
