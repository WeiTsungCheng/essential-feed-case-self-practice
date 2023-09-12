//
//  FeedImageDataLoaderWithFallbackCompositeTest.swift
//  EssentialApp
//
//  Created by WEI-TSUNG CHENG on 2023/9/12.
//

import XCTest
import EssentialFeedStudy

class FeedImageDataLoaderWithFallbackComposite: FeedImageDataLoader {
    
    private class Task: FeedImageDataLoaderTask {
        func cancel() {
            
        }
    }
    
    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        
    }

    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> EssentialFeedStudy.FeedImageDataLoaderTask {
        
        return Task()
    }
}


class FeedImageDataLoaderWithFallbackCompositeTest: XCTestCase {
    
    func test_init_doesNotLoadImageData() {
        let primaryLoader = LoaderSpy()
        let fallbackLoader = LoaderSpy()
        _ = FeedImageDataLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)

        XCTAssertTrue(primaryLoader.loadedURLs.isEmpty, "Expected no loaded URLs in the primary loader")
        XCTAssertTrue(fallbackLoader.loadedURLs.isEmpty, "Expected no loaded URLs in the fallback loader")
    }

    // MARK: - Helpers
    
    private class LoaderSpy: FeedImageDataLoader {
        
        var loadedURLs: [URL] {
            return messages.map { $0.url }
        }
        
        private struct Task: FeedImageDataLoaderTask {
            func cancel() {
                
            }
            
        }
      
        private var messages = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
        
        func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> EssentialFeedStudy.FeedImageDataLoaderTask {
            
            messages.append((url, completion))
            return Task()
        }
    }
}
