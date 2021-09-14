//
//  Page.swift
//  FinalSberProjectUITests
//
//  Created by Виктор Поволоцкий on 13.09.2021.
//

import Foundation
import XCTest

protocol Page {
    var app: XCUIApplication { get }

    init(app: XCUIApplication)
}
