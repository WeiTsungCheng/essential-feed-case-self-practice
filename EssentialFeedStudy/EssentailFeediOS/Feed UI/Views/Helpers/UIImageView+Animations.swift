//
//  UIImageView+Animation.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/8/30.
//

import UIKit

extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage
        guard newImage != nil else { return }
        
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    
    }
}
