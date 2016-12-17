//
//  TextFieldPhoneMask.swift
//
//  Created by Allan Alves on 9/5/16.
//  Copyright © 2016 bb. All rights reserved.
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

extension String {
    func insert(_ string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
    
    func cpfFormatted() -> String {
        if self.isCPFValid().value {
            var string = self.onlyNumbers()
            
            string.insert(".", at: string.index(string.startIndex, offsetBy: 3))
            string.insert(".", at: string.index(string.startIndex, offsetBy: 7))
            string.insert("-", at: string.index(string.startIndex, offsetBy: 11))
            
            return string
        }
        
        return self
    }

    func onlyNumbers() -> String {
        return self.replacingOccurrences(of: "[^0-9]", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }

}
