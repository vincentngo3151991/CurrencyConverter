//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import RxSwift
class ConverterViewModel: BaseTableViewModel {
    let rate : Variable<Rate?> = Variable(nil)
    let convertedValue : Variable<Double> = Variable(0)
    let baseValue : Variable<Double> = Variable(1)
    
    override init() {
        super.init()
        self.baseValue.asObservable()
            .subscribe(onNext: {value in
                self.convertedValue.value = value * (self.rate.value?.value ?? 0)
            }).addDisposableTo(self.disposeBag)
    }
    
    override func numberOfSection() -> Int {
        return 1
    }
    
    override func numberOfRow(inSection section: Int) -> Int {
        return 1
    }
    
    override func cellType(atIndexPath: IndexPath) -> BaseTableViewCell.Type {
        return ConverterCell.self
    }
    
    override func model(atIndex: IndexPath) -> BaseModel? {
        return self.rate.value
    }
}
