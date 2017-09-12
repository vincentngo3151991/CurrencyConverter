//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit

class ConverterViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ConverterViewModel()
    var dataSource : TableViewDataSource?
    override var routingParams: AnyObject? {
        didSet {
            self.viewModel.rate.value = routingParams as? Rate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConverterCell.registerCell(tableView: self.tableView)
        self.dataSource = TableViewDataSource(viewModel: self.viewModel)
        self.tableView.rx.setDelegate(self.dataSource!).addDisposableTo(self.disposeBag)
        self.tableView.rx.setDataSource(self.dataSource!).addDisposableTo(self.disposeBag)
        self.viewModel.rate.asObservable()
            .subscribe(onNext: { (exchange) in
                self.tableView.reloadData()
            }).addDisposableTo(self.disposeBag)
    }
}
