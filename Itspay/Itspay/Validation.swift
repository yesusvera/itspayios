//
//  Validation.swift
//  Cadastro-e
//
//  Created by Paulo Henrique on 13/11/15.
//  Copyright © 2015 Paulo Henrique. All rights reserved.
//

import Foundation
import UIKit

extension String {
    //Validate Email
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    //validate PhoneNumber
    func isPhoneNumber() -> Bool {
        let character  = CharacterSet(charactersIn: "+0123456789").inverted
        var filtered : String!
        let inputString = self.components(separatedBy: character)
        filtered = inputString.joined(separator: "")
        return self == filtered
    }
    
    //validate CardNumber
    func isCardNumber() -> Bool {
        let character  = CharacterSet(charactersIn: "0123456789").inverted
        var filtered : String!
        let inputString = self.components(separatedBy: character)
        filtered = inputString.joined(separator: "")
        return filtered.characters.count == 16
    }
    
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty){
            return true
        }
        return (self.trimmingCharacters(in: CharacterSet.whitespaces) == "")
    }
    
    func isCPFValid() -> (value:Bool, message:String) {
        let cpf = self.replacingOccurrences(of: "[^0-9]", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        if cpf.isEmptyOrWhitespace() {
            return (false, "CPF VAZIO.")
        }
        
        var firstSum, secondSum, firstDigit, secondDigit, firstDigitCheck, secondDigitCheck : Int
        
        if NSString(string: cpf).length != 11 {
            return (false, "CPF INVÁLIDO.")
        }
        
        if ((cpf == "00000000000") || (cpf == "11111111111") || (cpf == "22222222222") || (cpf == "33333333333") || (cpf == "44444444444") || (cpf == "55555555555") || (cpf == "66666666666") || (cpf == "77777777777") || (cpf == "88888888888") || (cpf == "99999999999")) {
            return (false, "CPF INVÁLIDO.")
        }
        
        let stringCpf = NSString(string: cpf)
        
        firstSum = 0
        for i in 0...8 {
            firstSum += NSString(string:stringCpf.substring(with: NSMakeRange(i, 1))).integerValue * (10 - i)
        }
        
        if firstSum % 11 < 2 {
            firstDigit = 0
        } else {
            firstDigit = 11 - (firstSum % 11)
        }
        
        secondSum = 0
        for i in 0...9 {
            secondSum += NSString(string:stringCpf.substring(with: NSMakeRange(i, 1))).integerValue * (11 - i)
        }
        
        if secondSum % 11 < 2 {
            secondDigit = 0
        } else {
            secondDigit = 11 - (secondSum % 11)
        }
        
        firstDigitCheck = NSString(string:stringCpf.substring(with: NSMakeRange(9, 1))).integerValue
        secondDigitCheck = NSString(string:stringCpf.substring(with: NSMakeRange(10, 1))).integerValue
        
        if ((firstDigit == firstDigitCheck) && (secondDigit == secondDigitCheck)) {
            return (true, "")
        }
        return (false, "CPF INVÁLIDO.")
    }
}
