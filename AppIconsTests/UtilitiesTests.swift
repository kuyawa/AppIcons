//
//  UtilitiesTests.swift
//  AppIcons
//
//  Created by Tomasz Pieczykolan on 30/06/2017.
//  Copyright © 2017 Armonia. All rights reserved.
//

import XCTest

class UtilitiesTests: XCTestCase {
    
    func testFileName() {
        XCTAssert(Utilities.fileName(for: 10.0, scale: 3) == "icon-10@3x.png")
        XCTAssert(Utilities.fileName(for: 35.5, scale: 2) == "icon-35.5@2x.png")
        XCTAssert(Utilities.fileName(for: 1.23, scale: 1) == "icon-1.2@1x.png")
        XCTAssert(Utilities.fileName(for: 1.27, scale: 5) == "icon-1.3@5x.png")
    }
}
