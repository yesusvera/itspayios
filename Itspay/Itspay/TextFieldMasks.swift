//
//  TextFieldPhoneMask.swift
//
//  Created by Allan Alves on 9/5/16.
//  Copyright © 2016 ItsPay. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
        case let (l?, r?):
            return l < r
        case (nil, _?):
            return true
        default:
            return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
        case let (l?, r?):
            return l > r
        default:
            return rhs < lhs
    }
}

class TextFieldPhoneMask: UITextField, UITextFieldDelegate {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.keyboardType = .decimalPad
        
        self.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var appendString = ""
        
        if range.length == 0 {
            switch range.location {
            case 0:
                appendString = "("
            case 3:
                appendString = ") "
            case 9:
                appendString = "-"
            default:
                break
            }
        }
        
        if text?.characters.count == 15 {
            if range.length == 1 {
                var tel = self.text
                tel = tel?.replacingOccurrences(of: "-", with: "")
                tel = tel?.insert("-", ind: 9)
                self.text = tel
            }
        }
        
        if text?.characters.count == 14 {
            if range.length == 0 {
                var tel = self.text
                tel = tel?.replacingOccurrences(of: "-", with: "")
                tel = tel?.insert("-", ind: 10)
                self.text = tel
            }
        }
        
        text?.append(appendString)
        
        if text?.characters.count > 14 && range.length == 0 {
            return false
        }
        
        return true
    }
}

class TextFieldCPFMask: UITextField, UITextFieldDelegate {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.keyboardType = .decimalPad
        
        self.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var appendString = ""
        
        if range.length == 0 {
            switch range.location {
            case 3:
                appendString = "."
            case 7:
                appendString = "."
            case 11:
                appendString = "-"
            default:
                break
            }
        }
        
        text?.append(appendString)
        
        if text?.characters.count > 13 && range.length == 0 {
            return false
        }
        
        return true
    }
}

class TextFieldBankMask: UITextField, UITextFieldDelegate {
    @IBInspectable var maxCharacteres = 50
    @IBInspectable var isDigitAvaiable = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.keyboardType = .decimalPad
        
        self.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            if isDigitAvaiable {
                textField.text = maskAgencyAccount(textField, max: maxCharacteres)
            }
            
            if textField.text!.characters.count == maxCharacteres-1 {
                textField.text = "\(textField.text!)\(string)"
            }
            
            if textField.text!.characters.count > maxCharacteres-1 {
                return false
            }
        }
        
        return true
    }
    
    func maskAgencyAccount(_ textField: UITextField!, max: Int) -> String {
        if ((textField.text!).characters.count > 0) && ((textField.text!).characters.count < max) {
            textField.text = textField.text!.replacingOccurrences(of: "-", with: "", options: .backwards, range: nil)
            let str : NSMutableString = NSMutableString(string: textField.text!)
            str.insert("-", at: (textField.text!).characters.count)
            return str as String
        }
        
        return textField.text!
    }
}

class TextFieldCurrencyMask: UITextField, UITextFieldDelegate {
    @IBInspectable var isRealVisible = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.keyboardType = .decimalPad
        
        self.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string != "" {
            textField.text = textField.text!.formatCurrency(range: range, string: string)
            
            if isRealVisible {
                textField.text = "R$ \(textField.text!.replacingOccurrences(of: "R$", with: ""))"
            } else {
                textField.text = textField.text!.replacingOccurrences(of: "R$", with: "")
            }
            
            return false
        }
        return true
    }
}

class TextFieldCardNumberMask: UITextField, UITextFieldDelegate {
    var textFieldMaskDelegate : TextFieldMaskDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.keyboardType = .decimalPad
        
        self.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textFieldMaskDelegate = textFieldMaskDelegate {
            if let method = textFieldMaskDelegate.textFieldDidBeginEditing {
                method(textField)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textFieldMaskDelegate = textFieldMaskDelegate {
            if let method = textFieldMaskDelegate.textFieldDidEndEditing {
                method(textField)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let textFieldMaskDelegate = textFieldMaskDelegate {
            if let method = textFieldMaskDelegate.textFieldShouldReturn {
                return method(textField)
            }
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let textFieldMaskDelegate = textFieldMaskDelegate {
            if let method = textFieldMaskDelegate.textField {
                return method(textField, range, string)
            }
        }
        
        var appendString = ""
        
        if range.length == 0 {
            switch range.location {
            case 4:
                appendString = "."
            case 9:
                appendString = "."
            case 14:
                appendString = "."
//            case 19:
//                appendString = "."
            default:
                break
            }
        }
        
        text?.append(appendString)
        
        if text?.characters.count > 19 && range.length == 0 {
            return false
        }
        
        return true
    }
}

@objc protocol TextFieldMaskDelegate {
    @objc optional func textFieldDidBeginEditing(_ textField: UITextField)
    @objc optional func textFieldDidEndEditing(_ textField: UITextField)
    @objc optional func textFieldShouldReturn(_ textField: UITextField) -> Bool
    @objc optional func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
}
