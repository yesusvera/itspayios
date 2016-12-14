//
//  LoginController.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/13/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class LoginController {
    static let sharedInstance = LoginController()
    
    static func createLoginRequestObject(cpf : String, password : String) -> LoginRequestObject {
        var dictionary = [String:Any]()
        
        dictionary["versaoConhecida"] = System.getAppVersion()
        dictionary["platformName"] = "iOS"
        dictionary["cpf"] = cpf.onlyNumbers()
        dictionary["plataformVersion"] = System.getOperatingSystemVersion()
        dictionary["deviceId"] = System.getUDID()
        dictionary["sistemaOperacional"] = 0
        dictionary["idInstituicao"] = 0
        dictionary["architectureInfo"] = ""
        dictionary["model"] = System.getCurrentDeviceModel()
        dictionary["versaoInstalada"] = System.getAppVersion()
        dictionary["latitude"] = Location.sharedInstance.currentLocation.coordinate.latitude
        dictionary["origemAcesso"] = 0
        dictionary["senha"] = password
        dictionary["idProcessadora"] = 0
        dictionary["longitude"] = Location.sharedInstance.currentLocation.coordinate.longitude
        
        print("Login Request Object: \(dictionary)")
        
        return LoginRequestObject(object: dictionary)
    }
}
