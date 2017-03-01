//
//  TokenCheck.swift
//  Itspay
//
//  Created by Junior Braga on 26/02/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class TokenCheckView:  UIViewController {
    
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var codeErrorLabel: UILabel!
    var codeAcess = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeErrorLabel.isHidden = true
        
        self.title = "Esqueci a Senha"
        
        CustomToastNotification().showNotification(view: view, title: "Financial", menssage: "Chave de ascesso é : 123", nameImage: "AppIconFinancial")
        
    }
    
    @IBAction func requestNewCode(_ sender: Any) {
        CustomToastNotification().showNotification(view: view, title: "Financial", menssage: "Chave de ascesso é : 123", nameImage: "AppIconFinancial")
    }
    
    
    @IBAction func checkCode(_ sender: Any) {
        
        if (code.text?.isEmpty)! {
            codeErrorLabel.isHidden = false
        }else if (code.text != codeAcess) {
            codeErrorLabel.isHidden = false
        }else{
            codeErrorLabel.isHidden = true
            self.performSegue(withIdentifier: "Checkout", sender: self)
        }
        
    }
}
