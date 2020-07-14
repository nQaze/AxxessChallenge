//
//  Alerts.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 14/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

class Alerts {
    
    class func showSelfDismissedAlertView(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.presentInOwnWindow(animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
    
    class func displayAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        alertController.presentInOwnWindow(animated: true, completion: nil)
    }
    
}

extension UIAlertController {
    
    func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(self, animated: animated, completion: completion)
    }
    
}
