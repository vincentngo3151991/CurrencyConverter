//
//  Rate.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import ObjectMapper
class Rate: BaseModel {
    var name : String = ""
    var value : Double = 0
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.name <- map["name"]
        self.value <- map["value"]
    }
    
}
