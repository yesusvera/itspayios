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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let value = UserDefaults.standard.object(forKey: "lastCPFLogged") as? String {
            textFieldCPF.text = value
        }
        
        textFieldPassword.text = ""
    }
    
    @IBAction func buttonForgotPasswordAction(_ sender: UIButton) {
        let alertView = UIAlertView.init(title: "Esqueci minha senha", message: "Esqueci minha senha", delegate: self, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        if isFormValid() {
            let loginRequestObject = LoginController.createLoginRequestObject(cpf, password: password)
            let url = Repository.createServiceURLFromPListValue(.services, key: "login")
            
            LoadingProgress.startAnimatingInWindow()
            Connection.request(url, method: .post, parameters: loginRequestObject.dictionaryRepresentation(), dataResponseJSON: { (dataResponse) in
                LoadingProgress.stopAnimating()
                
                if validateDataResponse(dataResponse, viewController: self) {
                    if let value = dataResponse.result.value {
                        LoginController.sharedInstance.loginResponseObject = LoginResponseObject(object: value)
                        
                        LoginController.sharedInstance.loginResponseObject.cpf = self.textFieldCPF.text?.onlyNumbers()
                        
                        UserDefaults.standard.set(self.textFieldCPF.text, forKey: "lastCPFLogged")
                        
                        if let token = LoginController.sharedInstance.loginResponseObject.token {
                            Connection.setHeadersAuthorization(with: token)
                        }
                        
                        self.performSegue(withIdentifier: "CardsSegue", sender: self)
                    }
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
