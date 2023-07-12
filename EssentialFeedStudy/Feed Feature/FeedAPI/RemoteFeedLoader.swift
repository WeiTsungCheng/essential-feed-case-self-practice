//
//  RemoteFeedLoader.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/10.
//

import Foundation

public final class RemoteFeedLoader {
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (Result) -> Void) {
        
        client.get(from: url, completion: { result in
            
            switch result {
            case let .success(data, response):
                
                do {
                    let items = try FeedItemsMapper.map(data, response)
                    completion(.success(items))
                    
                } catch {
                    completion(.failure(.invalidData))
                }
                
            case .failure:
                completion(.failure(.connectivity))
            }
        })
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        
        do {
            let items = try FeedItemsMapper.map(data, response)
            return .success(items)
            
        } catch {
            
            return .failure(.invalidData)
        }
    }
    
    
}


