//
//  LoginView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/12/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class LoginView: UITableViewController {
    @IBOutlet weak var labelErrorCPF: UILabel!
    @IBOutlet weak var labelErrorPassword: UILabel!
    
    @IBOutlet weak var textFieldCPF: TextFieldCPFMask!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonForgotPasswordAction(_ sender: UIButton) {
        let alertView = UIAlertView.init(title: "Esqueci minha senha", message: "Esqueci minha senha", delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        if isFormValid() {
            let alertView = UIAlertView.init(title: "Sucesso", message: "Sucesso", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }
    }
    
    func isFormValid() -> Bool {
        labelErrorCPF.isHidden = false
        labelErrorPassword.isHidden = false
        
        guard let cpf = textFieldCPF.text else {
            labelErrorCPF.text = "CPF Vazio."
            return false
        }

        if cpf.isEmptyOrWhitespace() {
            labelErrorCPF.text = "CPF Vazio."
            return false
        }
        
        let cpfValidation = cpf.isCPFValid()
        
        if !cpfValidation.value {
            labelErrorCPF.text = cpfValidation.message
            
            return false
        }
        
        labelErrorCPF.isHidden = true
        
        guard let password = textFieldPassword.text else {
            labelErrorPassword.text = "Senha Vazia."
            return false
        }
        
        if password.isEmptyOrWhitespace() {
            labelErrorPassword.text = "Senha Vazia."
            return false
        }
        
        labelErrorPassword.isHidden = true
        
        return true
    }
}
