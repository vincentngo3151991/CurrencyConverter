//
//  BaseCurrencyCell.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit

class BaseCurrencyCell: BaseTableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    let currencies = Constant.currencies
    let pickerView = UIPickerView()
    
    override class func cellId() -> String {
        return "baseCurrencyCellId"
    }
    
    override class func height() -> CGFloat {
        return 72
    }
    
    override func load(viewModel: BaseTableViewModel?, indexPath: IndexPath) {
        super.load(viewModel: viewModel, indexPath: indexPath)
        
        self.textField.text = self.currencies[(viewModel as! ExchangeViewModel).selectedCurrencyIndex]
        self.textField.inputView = self.pickerView
        self.textField.delegate = self
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    //MARK: UIPickerViewdelegate && UIPickerViewDataSource
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        (self.viewModel as? ExchangeViewModel)?.selectedCurrencyIndex = row
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.selectRow((self.viewModel as? ExchangeViewModel)?.selectedCurrencyIndex ?? 0
            , inComponent: 0, animated: true)
    }
}
