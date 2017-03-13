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
    
    var pemissionMarketPlace : Bool? = true
    
    var oneSignalUserId : String?
    var oneSignalToken : String?
    
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
    
    static func createRegisterLoginObject(_ email : String, birthday : String, cpf : String, password : String, cardNumber : String) -> [String:Any]  {
        var dictionary = [String:Any]()
        
        
        if let data = cardNumber.replacingOccurrences(of: ".", with: "").data(using: .utf8) {
            dictionary["credencial"] = data.sha512().toHexString()
        }
        
        dictionary["email"] = email
        dictionary["dataNascimento"] = birthday
        dictionary["cpf"] = cpf.onlyNumbers()
        dictionary["senha"] = password
        dictionary["origemCadastroLogin"] = ORIGEM_CADASTRO_LOGIN
        dictionary["idInstituicao"] = ID_INSTITUICAO
        dictionary["idProcessadora"] = ID_PROCESSADORA
        
        print("Create Register Object: \(dictionary)")
        
        return dictionary
    }
    
    static func createEmailURLPath() -> String {
        
        var url = Repository.createServiceURLFromPListValue(.services, key: "email")
        
          url += "\(ID_PROCESSADORA)/\(ID_INSTITUICAO)/buscar-email"
        
        if let value = LoginController.sharedInstance.loginResponseObject.cpf {
            url += "/\(value)"
        }
        
        return url
    }
    
    static func createChangeEmailURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "changeEmail")
    }
    
    static func createChangeEmailParametersDictionary(_ email : String) -> [String:Any] {
        var dictionary = [String:Any]()
        
        if let cpf = LoginController.sharedInstance.loginResponseObject.cpf {
            dictionary["documento"] = cpf
        }
        
        dictionary["email"] = email
        dictionary["idInstituicao"] = ID_INSTITUICAO
        dictionary["idProcessadora"] = ID_PROCESSADORA
        
        return dictionary
    }
    
    static func createChangePasswordURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "changePassword")
    }
    
    static func createChangePasswordParametersDictionary(_ password : String, newPassword : String) -> [String:Any] {
        var dictionary = [String:Any]()
        
        if let cpf = LoginController.sharedInstance.loginResponseObject.cpf {
            dictionary["cpf"] = cpf
        }
        
        dictionary["senha"] = password
        dictionary["novaSenha"] = newPassword
        dictionary["idInstituicao"] = ID_INSTITUICAO
        dictionary["idProcessadora"] = ID_PROCESSADORA
        
        return dictionary
    }
    
    static func handleRequestAlertsLogin(_ viewController : UIViewController, handlerAlert : @escaping (_ isUpdate: Bool?,_ alertAction: Bool?) -> Swift.Void) {
        if let value = LoginController.sharedInstance.loginResponseObject.requisitarAtualizacao {
            if value {
                if let message = LoginController.sharedInstance.loginResponseObject.requisicaoAtualizacaoMensagem {
                    let yesAction = UIAlertAction(title: "Sim", style: .default, handler: { (action) in
                        handlerAlert(true, true)
                    })
                    let noAction = UIAlertAction(title: "Não", style: .default) { (action) in
                        handlerAlert(true, false)
                    }
                    
                    AlertComponent.showAlert(title: "Atenção", message: message, actions: [yesAction, noAction], viewController: viewController)
                    
                    return
                }
            } else {
                if let isNotificationsOn = UserDefaults.standard.object(forKey: "isNotificationsOn") as? Bool {
                    if !isNotificationsOn {
                        if let value = LoginController.sharedInstance.loginResponseObject.requisitarPermissaoNotificacao {
                            if value {
                                if let message = LoginController.sharedInstance.loginResponseObject.requisicaoNotificacaoMensagem {
                                    let yesAction = UIAlertAction(title: "Sim", style: .default, handler: { (action) in
                                        UserDefaults.standard.set(true, forKey: "isNotificationsOn")
                                        
                                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "registerNotifications"), object: nil)
                                        
                                        let url = createEnableNotificationsURLPath()
                                        
                                        let parameters = createEnableNotificationsParameters()
                                        
                                        Connection.request(url, method: .post, parameters: parameters) { (dataResponse) in
                                            let message = getDataResponseMessage(dataResponse)
                                            
                                            print(message)
                                        }
                                        
                                        handlerAlert(false, true)
                                    })
                                    let noAction = UIAlertAction(title: "Não", style: .default) { (action) in
                                        UserDefaults.standard.set(false, forKey: "isNotificationsOn")
                                        
                                        handlerAlert(false, false)
                                    }
                                    
                                    AlertComponent.showAlert(title: "Atenção", message: message, actions: [yesAction, noAction], viewController:
                                        viewController)
                                    
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        
        handlerAlert(nil, nil)
    }
    
    static func createEnableNotificationsURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "enableNotifications")
    }
    
    static func createEnableNotificationsParameters() -> [String:Any] {
        var dictionary = [String:Any]()
        
        dictionary["deviceId"] = System.getUDID()
        
        if let value = LoginController.sharedInstance.loginResponseObject.idLogin {
            dictionary["idLogin"] = value
        }
        
        if let value = LoginController.sharedInstance.oneSignalUserId {
            dictionary["serviceDeviceId"] = value
        }
        
        return dictionary
    }
    
    static func createRecoverPasswordParameters(_ cpf : String) -> [String:Any] {
        var dictionary = [String:Any]()
        
        dictionary["documento"] = cpf
        dictionary["idInstituicao"] = ID_INSTITUICAO
        dictionary["idProcessadora"] = ID_PROCESSADORA
        
        return dictionary
    }
    
    static func logout(_ viewController : UIViewController) {
        let url = Repository.createServiceURLFromPListValue(.services, key: "logout")
        
        Connection.request(url) { (dataResponse) in
            Connection.removeSession()
        }
        
        viewController.dismiss(animated: true, completion: nil)
    }
}
