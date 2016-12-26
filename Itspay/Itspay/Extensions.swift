//
//  Extensions.swift
//
//  Created by Arthur Augusto Sousa Marques on 8/2/16.
//  Copyright © 2016 ItsPay. All rights reserved.
//

import UIKit
import pop

extension UIViewController {
    fileprivate struct AssociatedKeys {
        static var pageIndex = 0
    }
    
    var pageIndex: Int? {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.pageIndex) as? Int else {
                return nil
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.pageIndex, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UITextField {
    fileprivate struct AssociatedKeys {
        static var isDefaultInputAcessoryViewOn = true
    }
    
    @IBInspectable var isDefaultInputAcessoryViewOn : Bool {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.isDefaultInputAcessoryViewOn) as? Bool else {
                return true
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.isDefaultInputAcessoryViewOn, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    override open func awakeFromNib() {
        if self.isDefaultInputAcessoryViewOn {
            addInputAccessoryViewDoneButton()
        }
    }
    
    func addInputAccessoryViewDoneButton() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black.withAlphaComponent(0.1)
        toolBar.sizeToFit()
        
        let closeButton = UIBarButtonItem(title: "OK", style: .done , target: self, action: #selector(self.resignFirstResponder))
        closeButton.tintColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, closeButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.inputAccessoryView = toolBar
    }
}

extension UIColor {
    static func colorFrom(hex: String) -> UIColor {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        cString = (cString as NSString).substring(from: 0)
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}

extension String {
    func formatCurrency(range : NSRange, string : String) -> String {
        let oldText = self as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
        var newTextString = newText
        
        let digits = NSCharacterSet.decimalDigits
        var digitText = ""
        for c in newTextString.unicodeScalars {
            if digits.contains(c) {
                digitText += "\(c)"
            }
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        let numberFromField = (NSString(string: digitText).doubleValue)/100
        if let formattedText = formatter.string(for: numberFromField) {
            return formattedText
        }
        return ""
    }
    
    func getCurrencyDouble() -> Double? {
        return Double(self.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "%", with: ""))
    }
    
    func getCurrencyString() -> String {
        return self.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: "")
    }
    
    func formatToLocalCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        if let value = Double(self) {
            if let formattedText = formatter.string(for: value) {
                return formattedText.replacingOccurrences(of: "R$", with: "")
            }
        }
        
        return self
    }
    
    func formatToCurrencyReal() -> String {
        let currency = self.formatToLocalCurrency()
        
        return "R$ \(currency)"
    }
    
    func formatToLocalCurrency(with threeDecimals : String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.minimumFractionDigits = 3
        
        if let value = Double(threeDecimals) {
            if let formattedText = formatter.string(for: value) {
                return formattedText.replacingOccurrences(of: "R$", with: "")
            }
        }
        
        return threeDecimals
    }
}
