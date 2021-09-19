//
//  SnapShotTests.swift
//  FinalSberProjectUITests
//
//  Created by Виктор Поволоцкий on 19.09.2021.
//

import Foundation
import XCTest
import SnapshotTesting
@testable import MangaRead

class FinalSberProjectsSnapShotTests: XCTestCase {
    var sut: UIViewController!

    override func setUp() {
        super.setUp()
        sut = ReadViewController()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testForReadVc() throws {
        // assert
        assertSnapshot(matching: sut, as: .image(on: .iPhoneSe))
    }
}
