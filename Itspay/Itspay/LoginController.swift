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
        var dictionary = [String:Any?]()
        
        dictionary["versaoConhecida"] = nil
        dictionary["platformName"] = "iOS"
        dictionary["cpf"] = cpf
        dictionary["plataformVersion"] = nil
        dictionary["deviceId"] = System.getUDID()
        dictionary["sistemaOperacional"] = System.getOperatingSystemVersion()
        dictionary["idInstituicao"] = nil
        dictionary["architectureInfo"] = nil
        dictionary["model"] = System.getCurrentDeviceModel()
        dictionary["versaoInstalada"] = System.getAppVersion()
        dictionary["latitude"] = ""
        dictionary["origemAcesso"] = ""
        dictionary["senha"] = password
        dictionary["idProcessadora"] = 0
        dictionary["longitude"] = ""
        
        return LoginRequestObject(object: dictionary)
    }
}
