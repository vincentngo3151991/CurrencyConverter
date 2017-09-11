//
//  CurrencyRequest.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import RxSwift
class CurrencyRequest: NetworkRequest {
    static func getCurrency(baseCurrency: String) -> Single<Exchange?> {
        return self.request(url: NetworkRoute.latestCurrency + "?base=\(baseCurrency)", method: .get, modelType: Exchange.self)
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
    }
}
