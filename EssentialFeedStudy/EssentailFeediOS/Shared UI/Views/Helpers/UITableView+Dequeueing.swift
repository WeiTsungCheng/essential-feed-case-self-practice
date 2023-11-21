//
//  UITableView+Dequeueing.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/8/30.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
