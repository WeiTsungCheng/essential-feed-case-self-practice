//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by WEI-TSUNG CHENG on 2023/10/18.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
