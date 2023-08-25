//
//  UIRefreshControl+TestHelpers.swift
//  EssentailFeediOSTests
//
//  Created by WEI-TSUNG CHENG on 2023/8/25.
//

import UIKit

internal extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
