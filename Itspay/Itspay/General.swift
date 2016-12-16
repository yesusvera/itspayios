//
//  General.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/14/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import Alamofire

let appDelegate = UIApplication.shared.delegate!

//MARK: Instantiate Initial View Controller of Storyboard
func instantiateInitial(storyboard: String) -> UIViewController {
    return UIStoryboard(name: storyboard, bundle: nil).instantiateInitialViewController()!
}

//MARK: Instantiate View Controller from a Storyboard
func instantiateFrom(storyboard: String, identifier: String) -> UIViewController {
    return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier)
}

//MARK: Validate Data Response Alamofire
func validateDataResponse(dataResponse : Alamofire.DataResponse<Any>, viewController : UIViewController) -> Bool {
    guard let value = dataResponse.result.value else {
        let alertView = UIAlertView.init(title: "Erro", message: "Ocorreu algum erro inesperado.", delegate: viewController, cancelButtonTitle: "OK")
        alertView.show()
        
        return false
    }
    
    let errorObject = ErrorObject(object: value)
    
    if let msgError = errorObject.msg {
        let alertView = UIAlertView.init(title: "Erro", message: msgError, delegate: viewController, cancelButtonTitle: "OK")
        alertView.show()
        
        return false
    }
    
    return true
}
