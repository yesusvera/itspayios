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
    
    var loginResponseObject : LoginResponseObject!
    
    static func createLoginRequestObject(_ cpf : String, password : String) -> LoginRequestObject {
        var dictionary = [String:Any]()
        
        dictionary["versaoConhecida"] = System.getAppVersion()
        dictionary["platformName"] = "iOS"
        dictionary["cpf"] = cpf.onlyNumbers()
        dictionary["plataformVersion"] = System.getOperatingSystemVersion()
        dictionary["deviceId"] = System.getUDID()
        dictionary["sistemaOperacional"] = SISTEMA_OPERACIONAL
        dictionary["idInstituicao"] = ID_INSTITUICAO
        dictionary["architectureInfo"] = ""
        dictionary["model"] = System.getCurrentDeviceModel()
        dictionary["versaoInstalada"] = System.getAppVersion()
        dictionary["latitude"] = Location.sharedInstance.currentLocation.coordinate.latitude
        dictionary["origemAcesso"] = ORIGEM_ACESSO
        dictionary["senha"] = password
        dictionary["idProcessadora"] = ID_PROCESSADORA
        dictionary["longitude"] = Location.sharedInstance.currentLocation.coordinate.longitude
        
        print("Login Request Object: \(dictionary)")
        
        return LoginRequestObject(object: dictionary)
    }
    
    static func createRegisterLoginObject(_ email : String, birthday : String, cpf : String, password : String) -> LoginRequestObject {
        var dictionary = [String:Any]()
        
        dictionary["email"] = email
        dictionary["dataNascimento"] = birthday
        dictionary["cpf"] = cpf.onlyNumbers()
        dictionary["senha"] = password
        dictionary["origemCadastroLogin"] = ORIGEM_CADASTRO_LOGIN
        dictionary["credencial"] = CREDENCIAL
        dictionary["idInstituicao"] = ID_INSTITUICAO
        dictionary["idProcessadora"] = ID_PROCESSADORA
        
        print("Create Register Object: \(dictionary)")
        
        return LoginRequestObject(object: dictionary)
    }
    
    static func logout() {
        let url = Repository.createServiceURLFromPListValue(.services, key: "logout")
        
        Connection.request(url) { (dataResponse) in }
    }
}
