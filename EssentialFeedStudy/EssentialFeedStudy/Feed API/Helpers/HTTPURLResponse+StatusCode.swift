//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeedStudy
//
//  Created by WEI-TSUNG CHENG on 2023/9/8.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
