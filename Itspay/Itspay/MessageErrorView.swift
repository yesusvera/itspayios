//
//  MessageErrorView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/27/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class MessageErrorView: UIViewController {
    @IBOutlet weak var labelError: UILabel!

    @IBInspectable var msgError = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelError.text = msgError
    }
    
    func updateView(_ msgError : String) {
        labelError.text = msgError
    }
}
