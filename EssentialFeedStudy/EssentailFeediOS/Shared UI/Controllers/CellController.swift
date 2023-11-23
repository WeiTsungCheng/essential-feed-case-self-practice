//
//  CellController.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/11/23.
//

import UIKit
import EssentialFeedStudy

public struct CellController {
    let dataSource: UITableViewDataSource
    let delegate: UITableViewDelegate?
    let dataSourcePrefetching: UITableViewDataSourcePrefetching?
    
    public init(_ dataSource: UITableViewDataSource, delegate: UITableViewDelegate, dataSourcePrefetching: UITableViewDataSourcePrefetching) {
        self.dataSource = dataSource
        self.delegate = delegate
        self.dataSourcePrefetching = dataSourcePrefetching
    }
    
    public init(_ dataSource: UITableViewDataSource) {
        self.dataSource = dataSource
        self.delegate = nil
        self.dataSourcePrefetching = nil
    }
}
