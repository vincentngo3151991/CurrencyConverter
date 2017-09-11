//
//  BaseViewController.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import RxSwift

protocol BaseViewControllerDelegate : class {}

class BaseViewController: UIViewController, BaseViewControllerDelegate {
    weak var delegate : BaseViewControllerDelegate?
    let disposeBag = DisposeBag()
    var routingParams: AnyObject?
}
