//
//  LoginView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/12/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import CoreLocation

class LoginView: UITableViewController, CLLocationManagerDelegate {
    @IBOutlet weak var labelErrorCPF: UILabel!
    @IBOutlet weak var labelErrorPassword: UILabel!
    
    @IBOutlet weak var textFieldCPF: TextFieldCPFMask!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var cpf : String!
    var password : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func buttonForgotPasswordAction(_ sender: UIButton) {
        let alertView = UIAlertView.init(title: "Esqueci minha senha", message: "Esqueci minha senha", delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        if isFormValid() {
            let loginRequestObject = LoginController.createLoginRequestObject(cpf: cpf, password: password)
            let url = Repository.getPListValue(.services, key: "login")
            
            Connection.request(url, method: .post, parameters: loginRequestObject.dictionaryRepresentation(), headers: nil, dataResponseJSON: { (dataResponse) in
                if validateDataResponse(dataResponse: dataResponse, viewController: self) {
                    let alertView = UIAlertView.init(title: "Sucesso", message: "Login Efetuado.", delegate: self, cancelButtonTitle: "OK")
                    alertView.show()
                }
            })
        }
    }
    
    func isFormValid() -> Bool {
        labelErrorCPF.isHidden = false
        labelErrorPassword.isHidden = false
        
        guard let cpfValidation = textFieldCPF.text else {
            labelErrorCPF.text = "CPF Vazio."
            return false
        }

        if cpfValidation.isEmptyOrWhitespace() {
            labelErrorCPF.text = "CPF Vazio."
            return false
        }
        
        let cpfValid = cpfValidation.isCPFValid()
        
        if !cpfValid.value {
            labelErrorCPF.text = cpfValid.message
            
            return false
        }
        
        cpf = cpfValidation
        
        labelErrorCPF.isHidden = true
        
        guard let passwordValidation = textFieldPassword.text else {
            labelErrorPassword.text = "Senha Vazia."
            return false
        }
        
        if passwordValidation.isEmptyOrWhitespace() {
            labelErrorPassword.text = "Senha Vazia."
            return false
        }
        
        password = passwordValidation
        
        labelErrorPassword.isHidden = true
        
        return true
    }
}
