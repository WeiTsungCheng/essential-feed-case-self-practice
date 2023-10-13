//
//  EssentialAppUIAcceptanceTests.swift
//  EssentialAppUIAcceptanceTests
//
//  Created by WEI-TSUNG CHENG on 2023/10/13.
//

import EssentialFeedStudy
import EssentailFeediOS

import XCTest

final class EssentialAppUIAcceptanceTests: XCTestCase {
    
    func test_onLaunch_displayRemoteFeedWhenCustomerHasConnectivity() {
        let app = XCUIApplication()
        
        app.launch()
        
        XCTAssertEqual(app.cells.count, 22)
        XCTAssertEqual(app.cells.firstMatch.images.count, 1)

    }
    
}
