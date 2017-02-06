//
//  ButtonAction.swift
//  Itspay
//
//  Created by Junior Braga on 06/02/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import Foundation

class ButtonAction: UIButton {
    @IBInspectable var isActionButton : Bool = true {
        didSet {
        }
    }
    
    override func awakeFromNib() {
        if isActionButton {
            self.backgroundColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
            self.tintColor = UIColor.white
            self.setTitleColor(UIColor.white, for: .normal)
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 5
        }
    }
}
