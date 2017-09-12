//
//  ConverterCell.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import RxSwift
class ConverterCell: BaseTableViewCell {
    @IBOutlet weak var baseTextField: UITextField!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var convertedLabel: UILabel!
    @IBOutlet weak var convertedTitleLabel: UILabel!
    let disposedBag = DisposeBag()
    override class func cellId() -> String {
        return "converterCellId"
    }

    override class func height() -> CGFloat {
        return 189
    }
    
    override func load(viewModel: BaseTableViewModel?, indexPath: IndexPath) {
        super.load(viewModel: viewModel, indexPath: indexPath)
        
        let rate = viewModel?.model(atIndex: indexPath) as? Rate
        let vm = viewModel as? ConverterViewModel
        self.baseLabel.text = rate?.base
        self.baseTextField.text = String(format: "%.2f", vm?.baseValue.value ?? 0)
        self.convertedTitleLabel.text = rate?.name
        self.baseTextField.rx.text
            .map { (string) -> Double in
                return Double(string ?? "0") ?? 0
        }.bind(to: (vm?.baseValue)!).addDisposableTo(self.disposedBag)
        vm?.convertedValue.asObservable()
            .map({ (double) -> String in
                return String(format: "%.2f", double)
            }).bind(to: self.convertedLabel.rx.text).addDisposableTo(self.disposedBag)
    }
}
