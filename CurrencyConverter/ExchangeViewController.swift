//
//  ExchangeViewController.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExchangeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ExchangeViewModel()
    var dataSource : TableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BaseCurrencyCell.registerCell(tableView: self.tableView)
        ConvertedCurrencyCell.registerCell(tableView: self.tableView)
        self.dataSource = TableViewDataSource(viewModel: self.viewModel)
        self.tableView.rx.setDelegate(self.dataSource!).addDisposableTo(self.disposeBag)
        self.tableView.rx.setDataSource(self.dataSource!).addDisposableTo(self.disposeBag)
        self.viewModel.exchange.asObservable()
            .subscribe(onNext: { (exchange) in
                self.tableView.reloadData()
            }).addDisposableTo(self.disposeBag)
        self.tableView.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: false)
                let rate = self?.viewModel.model(atIndex: indexPath) as? Rate
                rate?.base = Constant.currencies[self?.viewModel.selectedCurrencyIndex ?? 0]
                ControllerRoute.route(path: .ConverterViewController, sender: self!, parameters: rate)
            }).addDisposableTo(self.disposeBag)
        self.viewModel.selectedCurrencyIndex = 0
    }
}
