//
//  ImageComment.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/11/15.
//

import Foundation

public struct ImageComment: Equatable {
    public let id: UUID
    public let message: String
    public let createAt: Date
    public let username: String
    
    public init(id: UUID, message: String, createAt: Date, username: String) {
        self.id = id
        self.message = message
        self.createAt = createAt
        self.username = username
    }
}
