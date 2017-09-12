//
//  ConvertedCurrencyCell.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit

class ConvertedCurrencyCell: BaseTableViewCell {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override class func cellId() -> String {
        return "convertedCurrencyCellId"
    }
    
    override class func estimatedHeight() -> CGFloat {
        return 100
    }
    
    override func load(viewModel: BaseTableViewModel?, indexPath: IndexPath) {
        super.load(viewModel: viewModel, indexPath: indexPath)
        
        let rate = viewModel?.model(atIndex: indexPath) as? Rate
        self.nameLabel.text = rate?.name
        self.valueLabel.text = String(format: "%.2f", rate?.value ?? 0)
    }
}
