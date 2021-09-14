//
//  DescriptionPage.swift
//  FinalSberProjectUITests
//
//  Created by Виктор Поволоцкий on 14.09.2021.
//

import Foundation
import XCTest

class DescriptionPage: Page {
    var app: XCUIApplication

    private var descripLabel: XCUIElement { return app.staticTexts["description"] }

    required init(app: XCUIApplication) {
        self.app = app
    }

    func checkDescriptionOnExist(then:@escaping (Bool) -> Void) {
        then(descripLabel.exists)
    }
}
