//
//  FeedImageDataMapper.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/11/17.
//

import Foundation

public final class FeedImageDataMapper {
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> Data {
        guard response.isOK, !data.isEmpty else {
            throw Error.invalidData
        }
        
        return data
    }
}
