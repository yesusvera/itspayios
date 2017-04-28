//
//  RegisterLoginController.swift
//  Itspay
//
//  Created by Junior Braga on 27/04/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import Foundation


import UIKit

class RegisterLoginController {
    
    static func createValidUser() -> [String:Any] {
        var dictionary = [String:Any]()
    
        var cadastro : CadastroSingleton = CadastroSingleton.sharedInstance
        
        let currentDate = NSDate()
        var dateAsString = String(describing: currentDate)
      
        dictionary["credencial"] = cadastro.numberCard.replacingOccurrences(of: ".", with: "").sha512().uppercased()
        
        dictionary["dataNascimento"] = Utils.GetDateFromString(DateStr: cadastro.burthday)
        dictionary["cpf"] = cadastro.cpf.onlyNumbers()
    
        CadastroSingleton.sharedInstance.chaveToken =  CadastroSingleton.sharedInstance.celular + dateAsString
    
        dictionary["chave"] = CadastroSingleton.sharedInstance.chaveToken
        dictionary["celular"] = CadastroSingleton.sharedInstance.celular
        dictionary["idInstituicao"] = ID_INSTITUICAO
        dictionary["idProcessadora"] = ID_PROCESSADORA
    
        return dictionary
    }
    
    
}
