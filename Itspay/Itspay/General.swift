//
//  General.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/14/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import Alamofire

//MARK: Instantiate Initial View Controller of Storyboard
func instantiateInitial(_ storyboard: String) -> UIViewController {
    return UIStoryboard(name: storyboard, bundle: nil).instantiateInitialViewController()!
}

//MARK: Instantiate View Controller from a Storyboard
func instantiateFrom(_ storyboard: String, identifier: String) -> UIViewController {
    return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier)
}

//MARK: Validate Data Response Alamofire
func validateDataResponse(_ dataResponse : Alamofire.DataResponse<Any>, showAlert : Bool, viewController : UIViewController) -> Bool {
    guard let value = dataResponse.result.value else {
        if showAlert {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Ocorreu algum erro inesperado.", viewController: viewController)
        }
        
        return false
    }
    
    let errorObject = ErrorObject(object: value)
    
    if let msgError = errorObject.msg {
        if showAlert {
            var title = "Erro"
            
            if msgError.contains("sucess") {
                title = "Sucesso"
            }else{
                if dataResponse.response?.statusCode == 403 {
                    NotificationCenter.default.post(name: NSNotification.Name.init("expiredSessionObserver"), object: nil)
                }
            }
            
            AlertComponent.showSimpleAlert(title: title, message: msgError, viewController: viewController)
        }
        
        return false
    }
    
    return true
}

func getDataResponseMessage(_ dataResponse : Alamofire.DataResponse<Any>) -> String {
    guard let value = dataResponse.result.value else {
        return "Ocorreu algum erro inesperado."
    }
    
    let errorObject = ErrorObject(object: value)
    
    if let msgError = errorObject.msg {
        return msgError
    }
    
    return ""
}

