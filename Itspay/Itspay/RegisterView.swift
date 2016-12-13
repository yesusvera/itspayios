//
//  RegisterView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/12/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class RegisterView: UITableViewController {
    @IBOutlet weak var labelErrorBirthday: UILabel!
    @IBOutlet weak var labelErrorCPF: UILabel!
    @IBOutlet weak var labelErrorEmail: UILabel!
    @IBOutlet weak var labelErrorEmailConfirmation: UILabel!
    @IBOutlet weak var labelErrorPassword: UILabel!
    @IBOutlet weak var labelErrorPasswordConfirmation: UILabel!
    
    @IBOutlet weak var textFieldBirthday: UITextField!
    @IBOutlet weak var textFieldCPF: TextFieldCPFMask!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldEmailConfirmation: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPasswordConfirmation: UITextField!
    
    @IBOutlet weak var switchConfirmationValue: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cadastro"
    }
    
    @IBAction func buttonDoLoginAction(_ sender: UIButton) {
        if isFormValid() {
            let alertView = UIAlertView.init(title: "Sucesso", message: "Sucesso", delegate: self, cancelButtonTitle: "OK")
            alertView.show()
        }
    }
    
    func isFormValid() -> Bool {
        labelErrorBirthday.isHidden = false
        labelErrorCPF.isHidden = false
        labelErrorEmail.isHidden = false
        labelErrorEmailConfirmation.isHidden = false
        labelErrorPassword.isHidden = false
        labelErrorPasswordConfirmation.isHidden = false
        
        guard let birthday = textFieldCPF.text else {
            labelErrorBirthday.text = "Data de nascimento Vazia."
            return false
        }
        
        if birthday.isEmptyOrWhitespace() {
            labelErrorBirthday.text = "Data de nascimento Vazia."
            return false
        }
        
        labelErrorBirthday.isHidden = true
        
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
        
        guard let email = textFieldEmail.text else {
            labelErrorEmail.text = "Email Vazio."
            return false
        }
        
        if email.isEmptyOrWhitespace() {
            labelErrorEmail.text = "Email Vazio."
            return false
        }
        
        if !email.isEmail() {
            labelErrorEmail.text = "Email Inválido."
            return false
        }
        
        labelErrorEmail.isHidden = true
        
        guard let emailConfirmation = textFieldEmailConfirmation.text else {
            labelErrorEmailConfirmation.text = "Confirmação de Email Vazia."
            return false
        }
        
        if emailConfirmation.isEmptyOrWhitespace() {
            labelErrorEmailConfirmation.text = "Confirmação de Email Vazia."
            return false
        }
        
        if email != emailConfirmation {
            labelErrorEmailConfirmation.text = "Confirmação de Email Inválida."
            return false
        }
        
        labelErrorEmailConfirmation.isHidden = true
        
        guard let password = textFieldPassword.text else {
            labelErrorPassword.text = "Senha Vazia."
            return false
        }
        
        if password.isEmptyOrWhitespace() {
            labelErrorPassword.text = "Senha Vazia."
            return false
        }
        
        labelErrorPassword.isHidden = true
        
        guard let passwordConfirmation = textFieldPasswordConfirmation.text else {
            labelErrorPasswordConfirmation.text = "Confirmação de Senha Vazia."
            return false
        }
        
        if passwordConfirmation.isEmptyOrWhitespace() {
            labelErrorPasswordConfirmation.text = "Confirmação de Senha Vazia."
            return false
        }
        
        if password != passwordConfirmation {
            labelErrorPasswordConfirmation.text = "Confirmação de Senha Inválida."
            return false
        }
        
        labelErrorPasswordConfirmation.isHidden = true
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebViewSegue" {
            let viewController = segue.destination as! WebView
            viewController.textTitle = "Termos de Uso"
            
            let url = URL(string: Repository.getPListValue(.services, key: "termosDeUso"))
            viewController.selectedURL = url
        }
    }
}
