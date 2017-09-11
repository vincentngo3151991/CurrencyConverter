//
//  Exchange.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import ObjectMapper

class Exchange: BaseModel {
    var base: String?
    var date : String?
    var rates : Array<Rate?> = Array()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.base <- map["base"]
        self.date <- map["date"]
        //parsing rates
        for (name, value) in map.JSON["rates"] as! [String: Double] {
            self.rates.append(Rate(JSONString: "\"name\":\(name),\"value\":\(value)"))
        }
    }
}
