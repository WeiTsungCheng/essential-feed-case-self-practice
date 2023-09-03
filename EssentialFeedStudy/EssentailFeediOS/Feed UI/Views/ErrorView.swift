//
//  ErrorView.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/9/3.
//

import UIKit

public final class ErrorView: UIView {
    
    @IBOutlet private var label: UILabel!
    
    public var message: String? {
        get { return label.text }
        set { label.text = newValue }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        label.text = nil
    }
}
