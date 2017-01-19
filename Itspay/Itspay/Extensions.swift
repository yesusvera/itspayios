//
//  Extensions.swift
//
//  Created by Arthur Augusto Sousa Marques on 8/2/16.
//  Copyright © 2016 ItsPay. All rights reserved.
//

import UIKit

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
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
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
    var height : CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
            
            label.numberOfLines = 100
            label.text = self
            label.sizeToFit()
                
            return label.frame.height
        }
        set {
            
        }
    }
    
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
    
    func jsonObject() -> Any? {
        if let data = self.data(using: .utf8) {
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                return object
            } catch {
            }
        }
        
        return nil
    }
    
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
    
    func isPasswordValid(min : Int, max : Int) -> Bool {
        if self == "" || self.characters.count < min || self.characters.count > max {
            return false
        }
        
        let letters = CharacterSet.letters
        let digits = CharacterSet.decimalDigits
        
        var hasLetter = false
        var hasDigit = false
        
        for character in self.unicodeScalars {
            if letters.contains(character) {
                hasLetter = true
            } else if digits.contains(character) {
                hasDigit = true
            }
        }
        
        if hasLetter && hasDigit {
            return true
        }
        
        return false
    }
    
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
    
    func cardNumberFormatted() -> String {
        var string = ""
        
        var count = 0
        for number in self.characters {
            if count != 0 && count % 4 == 0 {
                string += " "
            }
            
            string += "\(number)"
            
            count += 1
        }
        
        return string
    }
}

extension NSAttributedString {
    static func strikedText(_ text: String, color : UIColor) -> NSAttributedString {
        let textAttributes = [
            NSForegroundColorAttributeName: color,
            NSStrikethroughStyleAttributeName: 1
        ] as [String : Any]
        
        return NSAttributedString(string: text, attributes: textAttributes)
    }
    
    static func strokeText(_ text: String, color : UIColor, strokeColor : UIColor) -> NSAttributedString {
        let textAttributes = [
            NSForegroundColorAttributeName: color,
            NSStrokeColorAttributeName: strokeColor,
            NSStrokeWidthAttributeName: 1.0
        ] as [String : Any]
        
        return NSAttributedString(string: text, attributes: textAttributes)
    }
}

extension Array {
    func contains(_ object : AnyObject) -> Bool {
        if self.isEmpty {
            return false
        }
        
        let array = NSArray(array: self)
        
        return array.contains(object)
    }
    
    func index(of object : AnyObject) -> Int? {
        if self.contains(object) {
            let array = NSArray(array: self)
            
            return array.index(of: object)
        }
        
        return nil
    }
}

extension UILabel {
    var stringHeight : CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 44))
            
            label.numberOfLines = 100
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            
            return label.frame.height
        }
        set {
            
        }
    }
    func addShadow(with offset : CGSize, opacity : Float, radius : CGFloat) {
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
