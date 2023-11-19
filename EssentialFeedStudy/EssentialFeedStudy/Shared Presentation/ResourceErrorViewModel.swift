//
//  ResourceErrorViewModel.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/4.
//

import Foundation

public struct ResourceErrorViewModel {
    public let message: String?
    
    static var noError: ResourceErrorViewModel {
        return ResourceErrorViewModel(message: nil)
    }
    
    static func error(message: String) -> ResourceErrorViewModel {
        return ResourceErrorViewModel(message: message)
    }
}
