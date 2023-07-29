//
//  HTTPClient.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/7/12.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)

}
