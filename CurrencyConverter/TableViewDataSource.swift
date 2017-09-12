//
//  TableViewDataSource.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class TableViewDataSource: NSObject, RxTableViewDataSourceType, UITableViewDelegate, UITableViewDataSource {
    weak var viewModel : BaseTableViewModel?
    
    init(viewModel: BaseTableViewModel?) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, observedEvent: RxSwift.Event<Any>) {
        switch observedEvent {
        case .next( _):
            tableView.reloadData()
        case .error(let error):
            debugPrint("Error: \(error)")
        case .completed: break
            
        }
    }
    
    //MARK: UITableViewDelegate && UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : BaseTableViewCell! = self.viewModel?.cellType(atIndexPath: indexPath).dequeueCell(tableView: tableView)!
        cell.load(viewModel: self.viewModel, indexPath: indexPath)
    
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel?.numberOfSection() ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRow(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel?.cellType(atIndexPath: indexPath).height() ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel?.cellType(atIndexPath: indexPath).estimatedHeight() ?? 0
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return self.viewModel?.shouldHighLight(indexPath: indexPath) ?? false
    }
}
