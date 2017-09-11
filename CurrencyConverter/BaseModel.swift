//
//  BaseModel.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseModel: NSObject, Mappable {
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {}
}
