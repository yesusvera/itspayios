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
    
    @IBOutlet weak var labelTouchId: UILabel!
    @IBOutlet weak var switchTouchIdValue: UISwitch!
    
//    COLOR_BUTTON_PRINCIPAL_HEX
    
    var isTouchIdOn = false
    
    var cpf : String!
    var password : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isTouchID = UserDefaults.standard.object(forKey: "isTouchIdOn") as? Bool {
            isTouchIdOn = isTouchID
            
            switchTouchIdValue.isOn = isTouchIdOn
            switchTouchIdValue.onTintColor =  UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let value = UserDefaults.standard.object(forKey: "lastCPFLogged") as? String {
            textFieldCPF.text = value.cpfFormatted()
        }
        
        textFieldPassword.text = ""
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isTouchIdOn {
            if indexPath.row == 2 || indexPath.row == 3 {
                return 0
            }
        }
        
        if indexPath.row == 5 {
            if !TouchID.isTouchIDAvaiable().isAvaiable {
                labelTouchId.isHidden = true
                switchTouchIdValue.isHidden = true
                
                return 0
            }
            
            labelTouchId.isHidden = false
            switchTouchIdValue.isHidden = false
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    @IBAction func buttonForgotPasswordAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ForgotPassowordSegue", sender: self)
    }
    
    @IBAction func switchTouchIdAction(_ sender: UISwitch) {
        if sender.isOn {
            AlertComponent.showSimpleAlert(title: "Atenção", message: "Para ativar o TouchID você deve primeiro realizar o login com a sua senha para que a partir do próximo login neste dispositivo este possa ser feito pelo TouchID.", viewController: self)
        } else {
            isTouchIdOn = false
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        if isFormValid() {
            guard let _ = UserDefaults.standard.object(forKey: "isTouchIdOn") else {
                doLogin()
                return
            }
            
            if switchTouchIdValue.isOn {
                authenticateTouchId()
            } else {
                doLogin()
            }
        }
    }
    
    func authenticateTouchId() {
        TouchID.authenticateUserTouchID { (result, message, isPasswordNeeded) -> () in
            if isPasswordNeeded == true {
                self.isTouchIdOn = false
                
                self.tableView.reloadData()
            } else {
                if !result {
                    self.isTouchIdOn = false
                    
                    AlertComponent.showSimpleAlert(title: "Erro", message: message, viewController: self)
                    
                    self.tableView.reloadData()
                } else {
                    self.doLogin()
                }
            }
        }
    }
    
    func doLogin() {
        let loginRequestObject = LoginController.createLoginRequestObject(cpf, password: password)
        let url = Repository.createServiceURLFromPListValue(.services, key: "login")
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .post, parameters: loginRequestObject.dictionaryRepresentation(), dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let value = dataResponse.result.value {
                    LoginController.sharedInstance.loginResponseObject = LoginResponseObject(object: value)
                    
                    LoginController.handleRequestAlertsLogin(self, handlerAlert: { (isUpdate, alertAction) in
                        LoginController.sharedInstance.loginResponseObject.cpf = self.textFieldCPF.text?.onlyNumbers()
                        
                        UserDefaults.standard.set(self.cpf, forKey: "lastCPFLogged")
                        UserDefaults.standard.set(self.password, forKey: "lastPasswordLogged")
                        
                        if TouchID.isTouchIDAvaiable().isAvaiable {
                            UserDefaults.standard.set(self.switchTouchIdValue.isOn, forKey: "isTouchIdOn")
                        }
                        
                        if let token = LoginController.sharedInstance.loginResponseObject.token {
                            Connection.setHeadersAuthorization(with: token)
                        }
                        
                        self.performSegue(withIdentifier: "CardsSegue", sender: self)
                    })
                }
            }
        })
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
        
        if let value = UserDefaults.standard.object(forKey: "lastPasswordLogged") as? String {
            if switchTouchIdValue.isOn {
                if textFieldPassword.text == "" {
                    password = value
                } else {
                    password = textFieldPassword.text!
                }
                
                labelErrorPassword.isHidden = true
                
                return true
            }
        }
        
        guard let passwordValidation = textFieldPassword.text else {
            labelErrorPassword.text = "Senha Vazia."
            return false
        }
        
        if !passwordValidation.isPasswordValid(min: 6, max: 30) {
            labelErrorPassword.text = "Senha inválida. A senha deve possuir letras e números e ter entre 8 e 30 caracteres."
            return false
        }
        
        password = passwordValidation
        
        labelErrorPassword.isHidden = true
        
        return true
    }
}
