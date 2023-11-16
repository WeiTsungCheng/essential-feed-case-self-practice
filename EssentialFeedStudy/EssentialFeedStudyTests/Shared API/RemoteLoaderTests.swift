//
//  RemoteLoaderTests.swift
//  EssentialFeedStudyTests
//
//  Created by WEI-TSUNG CHENG on 2023/11/16.
//

import XCTest
import EssentialFeedStudy

class RemoteLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        
        let (sut, client) = makeSUT(url: url)
        sut.load{ _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
        
    }
    
    
    func test_load_requestDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        
        let (sut, client) = makeSUT(url: url)
        sut.load{ _ in }
        sut.load{ _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
        
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.connectivity)) {
            
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        }
        
    }
    
    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            
            expect(sut, toCompleteWith: failure(.invalidData)) {
                
                let json = makeItemsJSON([])
                client.complete(withStatusCode: code, data: json, at: index)
            }
            
        }
        
    }
    
    func test_load_deliversErrorOnHTTP200ResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.invalidData)) {
            
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        }
        
    }
    
    func test_load_deliversErrorOnHTTP200ResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .success([])) {
            
            let emptyListJSON = makeItemsJSON([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        }
    }
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        
        let (sut, client) = makeSUT()
        
        let item1 = makeItem(id: UUID(),
                             imageURL: URL(string: "https://a-url.com")!)
        
        let item2 = makeItem(id: UUID(),
                             description: "a description",
                             location: "a location",
                             imageURL: URL(string: "https://another-url.com")!)
        
        let items = [item1.model, item2.model]
        expect(sut, toCompleteWith: .success(items)) {
            
            let data = makeItemsJSON([item1.json, item2.json])
            client.complete(withStatusCode: 200, data: data)
        }
        
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        
        let url = URL(string: "http://any-url.com")!
        let client = HTTPClientSpy()
        var sut: RemoteLoader? = RemoteLoader(url: url, client: client)
        
        var capturedResults = [RemoteLoader.Result]()
        sut?.load { capturedResults.append($0) }
        sut = nil
       
        client.complete(withStatusCode: 200, data: makeItemsJSON([]))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteLoader, client: HTTPClientSpy) {
        
        let client = HTTPClientSpy()
        let sut = RemoteLoader(url: url, client: client)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        
        return (sut, client)
    }
    
    private func failure(_ error: RemoteLoader.Error) -> RemoteLoader.Result {
        return .failure(error)
    }
    
    private func makeItem(id: UUID, description: String? = nil, location: String? = nil, imageURL: URL) -> (model: FeedImage, json: [String: Any]) {
        
        let item = FeedImage(id: id, description: description, location: location, url: imageURL)
        let json = [
            "id": id.uuidString,
            "description": description,
            "location": location,
            "image": imageURL.absoluteString
        ].compactMapValues { $0 }
        
        return (item, json)
    }
    
    private func makeItemsJSON(_ items: [[String: Any]]) -> Data {
        
        let json = ["items": items]
        
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func expect(_ sut: RemoteLoader, toCompleteWith expectedResult: RemoteLoader.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        
        let exp = expectation(description: "wait for load completion")
        
        sut.load { receivedResult in

            switch (receivedResult, expectedResult) {
            case let (.success(receivedItem), .success(expectedItem)):
                XCTAssertEqual(receivedItem, expectedItem, file: file, line: line)

            case let (.failure(receivedError as RemoteLoader.Error), .failure(expectedError as RemoteLoader.Error)):
            
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)

            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
                
        action()
        
        wait(for: [exp], timeout: 1.0)

    }
    
}
