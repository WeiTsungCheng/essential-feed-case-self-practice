//
//  UIRefreshControl+Helpers.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/9/4.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
