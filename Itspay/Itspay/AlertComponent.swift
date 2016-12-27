//
//  AlertComponent.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/21/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class AlertComponent {
    static func showSimpleAlert(title : String, message : String, viewController : UIViewController) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(title : String, message : String, actions: [UIAlertAction], viewController : UIViewController) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
