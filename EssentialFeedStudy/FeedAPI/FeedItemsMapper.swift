//
//  FeedItemsMapper.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/12.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}

internal final class FeedItemsMapper {
    
    private static var OK_200: Int { return 200 }
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }
    
    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
     
        guard response.statusCode == OK_200, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            
            throw RemoteFeedLoader.Error.invalidData
        }
        
        return root.items
    }
    
}

