//
//  Button.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/1/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class Button: UIButton {
    @IBInspectable var isActionButton : Bool = true {
        didSet {
        }
    }
    
    override func awakeFromNib() {
        if isActionButton {
            self.backgroundColor = UIColor.colorFrom(hex: COLOR_BUTTON_HEX)
            self.tintColor = UIColor.white
            self.setTitleColor(UIColor.white, for: .normal)
        }
    }
}
