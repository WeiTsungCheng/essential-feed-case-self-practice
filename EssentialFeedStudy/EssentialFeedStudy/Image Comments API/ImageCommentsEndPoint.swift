//
//  ImageCommentsEndPoint.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/12/4.
//

import Foundation

public enum ImageCommentsEndpoint {
    case get(UUID)
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case let .get(id):
            return baseURL.appendingPathComponent("/v1/image/\(id.uuidString)/comments")
        }
    }
}
