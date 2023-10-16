//
//  UIImage+TestHelpers.swift
//  EssentailFeediOSTests
//
//  Created by WEI-TSUNG CHENG on 2023/10/16.
//

import UIKit

internal extension UIImage {
    static func make(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        return UIGraphicsImageRenderer(size: rect.size, format: format).image { rendererContext in
            color.setFill()
            rendererContext.fill(rect)
        }
    }
}
