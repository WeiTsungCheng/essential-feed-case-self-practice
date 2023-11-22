//
//  ImageCommentCellController.swift
//  EssentailFeediOS
//
//  Created by WEI-TSUNG CHENG on 2023/11/22.
//

import EssentialFeedStudy
import UIKit

public class ImageCommentCellController: CellController {

    private let model: ImageCommentViewModel
    
    public init(model: ImageCommentViewModel) {
        self.model = model
    }
    
    public func view(in tableView: UITableView) -> UITableViewCell {
        let cell: ImageCommentCell = tableView.dequeueReusableCell()
        cell.messageLabel.text = model.message
        cell.usernameLabel.text = model.username
        cell.dateLabel.text = model.date
        
        return cell
    }
    
    public func preload() {
        
    }
    
    public func cancelLoad() {
        
    }
    
    
}
