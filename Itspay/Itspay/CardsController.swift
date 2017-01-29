
//
//  CardsController.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/19/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import CryptoSwift

class CardsController {
    static let sharedInstance = CardsController()
    
    static func createVirtualCardsURLPath() -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "credencial")
        
        if let value = LoginController.sharedInstance.loginResponseObject.cpf {
            url += "/\(value)"
        }
        
        url += "/pessoa/\(TIPO_PESSOA)/processadora/\(ID_PROCESSADORA)/instituicao/\(ID_INSTITUICAO)"
        
        return url
    }

    static func createDetailVirtualCardsURLPath(_ credencial : Credenciais) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "credencial")
        
        if let value = credencial.idCredencial {
            url += "/\(value)/detalhes"
        }
        
        return url
    }
    
    static func createOpenPlasticURLPath(_ credencial : Credenciais) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "openPlastic")
        
        if let value = credencial.idPlastico {
            url += "/\(value)"
        }
        
        return url
    }

    static func createVirtualCardStatementURLPath(_ credencial : Credenciais, dataInicial : Date, dataFinal : Date) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "credencial")
        
        if let value = credencial.idCredencial {
            url += "/\(value)"
        }
        
        if let initialDate = DateFormatter.stringWith("yyyy-MM-dd", from: dataInicial), let endDate = DateFormatter.stringWith("yyyy-MM-dd", from: dataFinal) {
            url += "/extrato/data_inicial/\(initialDate)/data_final/\(endDate)"
        }
        
        return url
    }
    
    static func createUnlockedCardURLPath() -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "unlockedCards")
        
        if let value = LoginController.sharedInstance.loginResponseObject.cpf {
            url += "/\(value)"
        }
        
        url += "/pessoa/\(TIPO_PESSOA)/processadora/\(ID_PROCESSADORA)/instituicao/\(ID_INSTITUICAO)/desbloqueadas"
        
        return url
    }

    static func createSearchTariffURLPath(_ credencial : Credenciais) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "searchTariff")
        
        if let value = credencial.idConta {
            url += "/\(value)"
        }
        
        return url
    }
    
    static func createTariffProfileURLPath(_ credencial : Credenciais, tarifa : Int) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "tariffProfile")
        
        if let value = credencial.idConta {
            url += "/\(value)"
        }
        
        url += "/tarifa/\(tarifa)"
        
        return url
    }
    
    static func createBanksListURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "banks")
    }
    
    static func createBankTransferURLPath(_ agency : String, account : String, idBank : Int, price : String) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "bankTransfer")
        
        url += "/\(agency)"
        url += "/conta/\(account.replacingOccurrences(of: "-", with: ""))"
        url += "/banco/\(idBank)"
        url += "/valorTransferencia/\(price.getCurrencyString().replacingOccurrences(of: ".", with: ","))"
        
        return url
    }
    
    static func createCarrierInfoURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "carrierInfo")
    }
    
    static func createCarrierInfoParameters(cardNumber : String) -> [String:Any] {
        var dictionary = [String:Any]()
    
        if let data = cardNumber.data(using: .utf8) {
            dictionary["credencial"] = data.sha512().toHexString()
        }
        
        return dictionary
    }
    
    static func createCardTransferURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "cardTransfer")
    }
    
    static func createCardTransferParameters(_ virtualCard : Credenciais, cardNumber : String, password : String, price : String) -> [String:Any] {
        var dictionary = [String:Any]()
        
        if let value = virtualCard.contaPagamento {
            dictionary["contaOrigem"] = value
        }
        
        if let value = virtualCard.idCredencial {
            dictionary["idCredencialOrigem"] = value
        }
        
        if let data = cardNumber.replacingOccurrences(of: ".", with: "").data(using: .utf8) {
            dictionary["credencialDestino"] = data.sha512().toHexString()
        }
        
        if let token = LoginController.sharedInstance.loginResponseObject.token {
            let passwordConcatenated = password + token
            
            if let data = passwordConcatenated.data(using: .utf8) {
                dictionary["pinCredencialOrigem"] = data.sha512().toHexString()
            }
        }
        
        dictionary["valorTransferencia"] = price.getCurrencyDouble()
        dictionary["idInstituicaoOrigem"] = ID_INSTITUICAO
        
        return dictionary
    }
    
    static func createVirtualCardsListURLPath(_ virtualCard : Credenciais) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "virtualCardsAccount")
        
        if let value = virtualCard.idConta {
            url += "/\(value)"
        }
        
        return url
    }
    
    static func createNewVirtualCardURLPath(_ virtualCard : Credenciais) -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "newVirtualCard")
    }
    
    static func createNewVirtualCardParameters(_ virtualCard : Credenciais, cardName : String, months : Int)-> [String:Any] {
        var dictionary = [String:Any]()
        
        if let value = virtualCard.idConta {
            dictionary["idConta"] = value
        }

        if let value = virtualCard.idPessoa {
            dictionary["idPessoa"] = value
        }
        
        dictionary["virtualApelido"] = cardName
        dictionary["virtualMesesValidade"] = months
        dictionary["idUsuario"] = ID_USUARIO
        dictionary["virtual"] = true
        
        return dictionary
    }
    
    static func createSecuritySettingsURLPath(_ virtualCard : Credenciais) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "securitySettings")
        
        if let value = virtualCard.idCredencial {
            url += "/\(value)"
        }
        
        return url
    }
    
    static func createSecuritySettingsChangeStateURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "securitySettingsChangeState")
    }
    
    static func createSecuritySettingsChangeStateParameters(_ virtualCard : Credenciais, tipoEstado : Int)-> [String:Any] {
        var dictionary = [String:Any]()
        
        if let value = virtualCard.idCredencial {
            dictionary["idCredencial"] = value
        }
        
        if let value = virtualCard.idPessoa {
            dictionary["idUsuario"] = value
        }
        
        dictionary["tipoEstado"] = tipoEstado
        
        return dictionary
    }
    
    static func createComunicateLostURLPath(_ virtualCard : Credenciais) -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "comunicateLost")
    }
    
    static func createComunicateLostParameters(_ virtualCard : Credenciais)-> [String:Any] {
        var dictionary = [String:Any]()
        
        if let value = virtualCard.idCredencial {
            dictionary["idCredencial"] = value
        }
        
        dictionary["idUsuario"] = ID_USUARIO
        dictionary["status"] = STATUS_LOST
        
        return dictionary
    }
    
    static func createComunicateStealURLPath(_ virtualCard : Credenciais) -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "comunicateSteal")
    }
    
    static func createComunicateStealParameters(_ virtualCard : Credenciais)-> [String:Any] {
        var dictionary = [String:Any]()
        
        if let value = virtualCard.idCredencial {
            dictionary["idCredencial"] = value
        }
        
        dictionary["idUsuario"] = ID_USUARIO
        dictionary["status"] = STATUS_STEAL
        
        return dictionary
    }
    
    static func openPlastics(_ virtualCard : Credenciais, in imageView : UIImageView, showLoading : Bool) {
        let url = CardsController.createOpenPlasticURLPath(virtualCard)
        
        var superview = UIView()
        
        if showLoading {
            if let view = imageView.superview {
                superview = view
            } else {
                superview = imageView
            }
            
            LoadingProgress.startAnimating(in: superview, isAlphaReduced: false)
        }
        
        Connection.requestData(url, method: .get, parameters: nil, dataResponse: { (dataResponse) in
            if showLoading {
                LoadingProgress.stopAnimating(in: superview)
            }
            
            if let data = dataResponse {
                if let dataImage = Data(base64Encoded: data.base64EncodedString()) {
                    if dataImage.base64EncodedString().characters.count > 0 {
                        imageView.image = UIImage(data: dataImage)
                    } else {
                        imageView.image = UIImage(named: "CardDefault")
                    }
                } else {
                    imageView.image = UIImage(named: "CardDefault")
                }
            } else {
                imageView.image = UIImage(named: "CardDefault")
            }
        })
    }

    static func createGenerateTicketChargeURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "generateTicketCharge")
    }
    
    static func createGenerateTicketChargeParameters(_ virtualCard : Credenciais, price : String) -> [String:Any] {
        var dictionary = [String:Any]()

        if let value = virtualCard.contaPagamento {
            dictionary["contaPagamento"] = value
        }
        
        if let value = LoginController.sharedInstance.loginResponseObject.cpf {
            dictionary["documentoPortador"] = value
        }
        
        if let value = virtualCard.idProduto {
            dictionary["idProduto"] = value
        }
        
        if let value = virtualCard.email {
            dictionary["emailDestino"] = value
        }
        
        if let value = DateFormatter.stringWith("yyyy-MM-dd'T'HH:mm:ss", from: Date()) {
            dictionary["vencimento"] = value
        }
        
        dictionary["valor"] = price.getCurrencyDouble()
        dictionary["idInstituicao"] = ID_INSTITUICAO
        dictionary["idProcessadora"] = ID_PROCESSADORA

        return dictionary
    }
    
    static func createSendTicketEmailURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "sendTicketEmail")
    }
}
