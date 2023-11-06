//
//  HTTPClientStub.swift
//  EssentialAppTests
//
//  Created by WEI-TSUNG CHENG on 2023/10/15.
//

import Foundation
import EssentialFeedStudy

class HTTPClientStub: HTTPClient {
    private class Task: HTTPClientTask {
        func cancel() {}
    }
    
    private let stub: (URL) -> HTTPClient.Result
    init(stub: @escaping (URL) -> HTTPClient.Result) {
        self.stub = stub
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> EssentialFeedStudy.HTTPClientTask {
        
        completion(stub(url))
        return Task()
    }
    
}

extension HTTPClientStub {
    static var offline: HTTPClientStub {
        HTTPClientStub(stub: { _ in .failure(NSError(domain: "offline", code: 0))})
    }
    
    static func online(_ stub: @escaping (URL) -> (Data, HTTPURLResponse)) -> HTTPClientStub {
        return HTTPClientStub(stub: { url in .success(stub(url))})
    }
}
