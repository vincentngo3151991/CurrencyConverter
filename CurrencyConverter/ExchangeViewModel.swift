//
//  ExchangeViewModel.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import RxSwift
class ExchangeViewModel: BaseTableViewModel {
    let exchange : Variable<Exchange?> = Variable(nil)
    var selectedCurrencyIndex = 0 {
        didSet {
            CurrencyRequest.getCurrency(baseCurrency: Constant.currencies[selectedCurrencyIndex])
                        .subscribe(onSuccess: { (exchange) in
                            self.exchange.value = exchange
                        }) { (error) in
                            //Skip for now
            }.addDisposableTo(self.disposeBag)
        }
    }
    
    override func numberOfSection() -> Int {
        return 2
    }
    
    override func numberOfRow(inSection section: Int) -> Int {
        return section == 0 ? 1 : (exchange.value != nil ? exchange.value!.rates.count : 0)
    }
    
    override func model(atIndex: IndexPath) -> BaseModel? {
        return atIndex.section == 0 ? nil : self.exchange.value?.rates[atIndex.row]
    }
    
    override func cellType(atIndexPath: IndexPath) -> BaseTableViewCell.Type {
        if atIndexPath.section == 0 {
            return BaseCurrencyCell.self
        } else {
            return ConvertedCurrencyCell.self
        }
    }
}
