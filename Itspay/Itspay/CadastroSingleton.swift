//
//  CadastroSingleton.swift
//  Itspay
//
//  Created by Junior Braga on 25/02/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

public class CadastroSingleton{
    
    static let sharedInstance = CadastroSingleton()
    
    var numberCard: String = ""
    var burthday: String = ""
    var cpf:String = ""
    var email:String = ""
    var password: String = ""
    var celular:String = ""
    var chaveToken :String = ""
}
