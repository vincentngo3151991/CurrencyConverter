//
//  ControllerRoute.swift
//  CurrencyConverter
//
//  Created by Thunderiven on 9/11/17.
//  Copyright © 2017 Thunderiven. All rights reserved.
//

import UIKit
import JLRoutes

enum ControllerRoutePath : String {
    case Detail = ""
}

enum RouteMode: String {
    case Push, Present
}

class ControllerRoute: NSObject {
    static func configure() {
        
    }
    
    static func storyBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    
    // Use this method to route the controller to correct destination
    class func route(path: ControllerRoutePath, sender:BaseViewController, parameters:AnyObject? = nil, routeMode:RouteMode = .Push) {
        var params = [String : AnyObject]()
        params["sender"] = sender
        params["routeMode"] = routeMode.rawValue as AnyObject
        if (parameters != nil) {
            params["parameters"] = parameters
        }
        JLRoutes.routeURL(URL(string: path.rawValue), withParameters: params)
    }
    
    // This method is use to add route to the correct ViewController in the storyboard
    private class func addRoute(path: ControllerRoutePath, controllerIdentifier: String? = nil) {
        JLRoutes.global().addRoute(path.rawValue) { (params) -> Bool in
            let controller = ControllerRoute.storyBoard().instantiateViewController(withIdentifier: controllerIdentifier != nil ? controllerIdentifier! : path.rawValue) as! BaseViewController
            let routeMode = params["routeMode"] as! String
            let sender = params["sender"] as! BaseViewController
            controller.routingParams = params["parameters"] as AnyObject
            controller.delegate = sender
            if (routeMode == RouteMode.Push.rawValue && sender.navigationController != nil) {
                sender.navigationController?.pushViewController(controller, animated: true)
            } else {
                
                sender.navigationController?.present(controller, animated: true, completion: nil)
            }
            return true
        }
    }
}
