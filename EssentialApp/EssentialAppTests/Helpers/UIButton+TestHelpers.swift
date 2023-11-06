//
//  UIButton+TestHelpers.swift
//  EssentailFeediOSTests
//
//  Created by WEI-TSUNG CHENG on 2023/8/25.
//

import UIKit

internal extension UIButton {
    func simulateTap() {
        self.simulate(event: .touchUpInside)
    }
}
