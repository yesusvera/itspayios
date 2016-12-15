//
//  Extensions.swift
//  HOMEBROKER
//
//  Created by Arthur Augusto Sousa Marques on 8/2/16.
//  Copyright © 2016 bb. All rights reserved.
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
    open override func draw(_ rect: CGRect) {
        addInputAccessoryViewDoneButton()
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
