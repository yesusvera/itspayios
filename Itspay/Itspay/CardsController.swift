
//
//  CardsController.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/19/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

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
}
