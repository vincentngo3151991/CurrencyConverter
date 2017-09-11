//
//  NetworkRequest.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class NetworkRequest: NSObject {
    static func request<T:BaseModel>(url : String, method: HTTPMethod, modelType: T.Type, parameters:[String: Any]? = nil) -> Single<T?> {
        return Single<T?>.create(subscribe: { single -> Disposable in
            let request = Alamofire.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, method: method, parameters: parameters)
                .responseObject(completionHandler: { (response:DataResponse<T>) in
                    if (response.result.isFailure) {
                       single(.success(response.result.value!))
                    } else {
                        single(.error(response.result.error!))
                    }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }
}
