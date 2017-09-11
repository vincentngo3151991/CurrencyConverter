//
//  BaseViewModel.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import RxSwift
class BaseViewModel: NSObject {
    let error : Variable<Error?> = Variable(nil)
    var routingSubject : Variable<Any?> = Variable(nil)
    let disposeBag = DisposeBag()
}
