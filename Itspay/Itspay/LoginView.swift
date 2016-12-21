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
    
    var isTouchIdOn = false
    
    var cpf : String!
    var password : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isTouchID = UserDefaults.standard.object(forKey: "isTouchIdOn") as? Bool {
            isTouchIdOn = isTouchID
            
            switchTouchIdValue.isOn = isTouchIdOn
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let value = UserDefaults.standard.object(forKey: "lastCPFLogged") as? String {
            textFieldCPF.text = value
        }
        
        textFieldPassword.text = ""
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
        AlertComponent.showSimpleAlert(title: "Esqueci minha senha", message: "Esqueci minha senha", viewController: self)
    }
    
    @IBAction func switchTouchIdAction(_ sender: UISwitch) {
        if sender.isOn {
            AlertComponent.showSimpleAlert(title: "Atenção", message: "Para ativar o TouchID você deve primeiro realizar o login com a sua senha para que a partir do próximo login neste dispositivo este possa ser feito pelo TouchID.", viewController: self)
        }
    }
    
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        if isFormValid() {
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
                self.isTouchIdOn = true
            } else {
                if !result {
                    AlertComponent.showSimpleAlert(title: "Erro", message: message, viewController: self)
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
                    
                    LoginController.sharedInstance.loginResponseObject.cpf = self.textFieldCPF.text?.onlyNumbers()
                    
                    UserDefaults.standard.set(self.textFieldCPF.text, forKey: "lastCPFLogged")
                    
                    if TouchID.isTouchIDAvaiable().isAvaiable {
                        UserDefaults.standard.set(self.switchTouchIdValue.isOn, forKey: "isTouchIdOn")
                        
                        if self.switchTouchIdValue.isOn {
                            UserDefaults.standard.set(self.textFieldPassword.text, forKey: "lastPasswordLogged")
                        } else {
                            UserDefaults.standard.set("", forKey: "lastPasswordLogged")
                        }
                    }
                    
                    if let token = LoginController.sharedInstance.loginResponseObject.token {
                        Connection.setHeadersAuthorization(with: token)
                    }
                    
                    self.performSegue(withIdentifier: "CardsSegue", sender: self)
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
                password = value
                
                labelErrorPassword.isHidden = true
                
                return true
            }
        }
        
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
