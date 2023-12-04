//
//  FeedViewControllerTests+Assertions.swift
//  EssentailFeediOSTests
//
//  Created by WEI-TSUNG CHENG on 2023/8/25.
//

import XCTest
import EssentialFeedStudy
import EssentailFeediOS

extension FeedUIIntegrationTests {
    func assertThat(_ sut: ListViewController, isRendering feed: [FeedImage], file: StaticString = #filePath, line: UInt = #line) {
        
        // It's also important to run the current RunLoop to avoid memory leaks during the test.
        // If you don't run the RunLoop, some instances might be retained in memory even after the test finishes, which is considered a "test leak".
        // A test leak can affect the result of other tests, so it's essential to clean the memory within the test context. A reliable test suite runs each test in a clean state.
        sut.view.enforceLayoutCycle()
        
        guard sut.numberOfRenderedFeedImageViews() == feed.count else {
            return XCTFail("Expected \(feed.count) images, got \(sut.numberOfRenderedFeedImageViews()) instead.", file: file, line: line)
        }
        
        feed.enumerated().forEach { index, image in
            assertThat(sut, hasViewConfiguredFor: image, at: index, file: file, line: line)
        }

        // On iOS 14+, you may need to execute the RunLoop one more time after asserting the UI state to reliably prevent the test leak
        executeRunLoopToCleanUpReferences()
    }
    
    internal func assertThat(_ sut: ListViewController, hasViewConfiguredFor image: FeedImage, at index: Int, file: StaticString = #filePath, line: UInt = #line) {
        let view = sut.feedImageView(at: index)
        
        guard let cell = view as? FeedImageCell else {
            return XCTFail("Expected \(FeedImageCell.self) instance, got \(String(describing: view)) instead", file: file, line: line)
        }
        
        let shouldLocationBeVisible = (image.location != nil)
        XCTAssertEqual(cell.isShowingLocation, shouldLocationBeVisible, "Expected `isShowingLocation` to be \(shouldLocationBeVisible) for image view at index (\(index))", file: file, line: line)
        
        XCTAssertEqual(cell.locationText, image.location, "Expected location text to be \(String(describing: image.location)) for image  view at index (\(index))", file: file, line: line)
        
        XCTAssertEqual(cell.descriptionText, image.description, "Expected description text to be \(String(describing: image.description)) for image view at index (\(index)", file: file, line: line)
    }

    private func executeRunLoopToCleanUpReferences() {
        RunLoop.current.run(until: Date())
    }
}
