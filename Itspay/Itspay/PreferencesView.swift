//
//  PreferencesView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/20/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import MessageUI

class PreferencesView: UITableViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldCurrentPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldNewPasswordConfirmation: UITextField!

    @IBOutlet weak var buttonValue: UIButton!
    
    var isEmailEditing = false
    var isPasswordEditing = false
    
    var email = ""
    var password = ""
    var newPassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Ajustes Gerais"
        
        getEmail()
        updateViewInfo()
    }
    
    func updateViewInfo() {
        self.textFieldEmail.text = email
    }
    
    func getEmail() {
        let url = LoginController.createEmailURLPath()
        
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let value = dataResponse.result.value as? NSDictionary {
                    if let email = value["email"] as? String {
                        self.email = email
                        self.updateViewInfo()
                    }
                }
            }
        })
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if isEmailEditing {
            if isEmailFormValid() {
                updateEmail()
            }
        } else {
            if isPasswordFormValid() {
                updatePassword()
            }
        }
    }
    
    func updateEmail() {
        let url = LoginController.createChangeEmailURLPath()
        
        Connection.request(url, method: .put, parameters: LoginController.createChangeEmailParametersDictionary(email), dataResponseJSON: { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {    }
        })
    }
    
    func updatePassword() {
        let url = LoginController.createChangePasswordURLPath()
        
        Connection.request(url, method: .put, parameters: LoginController.createChangePasswordParametersDictionary(password, newPassword: newPassword), dataResponseJSON: { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {    }
            
            UserDefaults.standard.set(self.newPassword, forKey: "lastPasswordLogged")
            
            self.clearAllFields()
        })
    }
    
    func clearAllFields() {
        textFieldCurrentPassword.text = ""
        textFieldNewPassword.text = ""
        textFieldNewPasswordConfirmation.text = ""
    }
    
    func isEmailFormValid() -> Bool {
        guard let emailValidation = textFieldEmail.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Email inválido.", viewController: self)
            return false
        }
        
        email = emailValidation
        
        return true
    }
    
    func isPasswordFormValid() -> Bool {
        guard let passwordValidation = textFieldCurrentPassword.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Senha atual inválida.", viewController: self)
            return false
        }
        
        password = passwordValidation
        
        guard let newPasswordValidation = textFieldNewPassword.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Nova Senha inválida. A senha deve possuir letras e números e ter entre 8 e 30 caracteres.", viewController: self)
            return false
        }
        
        if !newPasswordValidation.isPasswordValid() {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Nova Senha inválida. A senha deve possuir letras e números e ter entre 8 e 30 caracteres.", viewController: self)
            return false
        }
        
        guard let newPasswordConfirmationValidation = textFieldNewPasswordConfirmation.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Confirmação de senha inválida.", viewController: self)
            return false
        }
        
        if newPasswordValidation != newPasswordConfirmationValidation {
            AlertComponent.showSimpleAlert(title: "Erro", message: "As senhas devem ser iguais.", viewController: self)
            return false
        }
        
        newPassword = newPasswordValidation
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                isEmailEditing = !isEmailEditing
                
                if isEmailEditing {
                    isPasswordEditing = false
                }
                
                buttonValue.setTitle("Trocar Email", for: .normal)
            }
            if indexPath.row == 2 {
                isPasswordEditing = !isPasswordEditing
                
                if isPasswordEditing {
                    isEmailEditing = false
                }
                
                buttonValue.setTitle("Trocar Senha", for: .normal)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.performSegue(withIdentifier: "showWebViewSegue", sender: self)
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                UIApplication.shared.openURL(URL(string: "tel://\(PHONE_SAC)")!)
            } else if indexPath.row == 1 {
                UIApplication.shared.openURL(URL(string: "tel://\(PHONE_OUVIDORIA)")!)
            } else if indexPath.row == 2 {
                let mailComposeViewController = configuredMailComposeViewController()
                
                if MFMailComposeViewController.canSendMail() {
                    self.present(mailComposeViewController, animated: true, completion: nil)
                }
            }
        }
        
        tableView.beginUpdates()
        tableView.reloadData()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 1 && !isEmailEditing {
                return 0
            }
            if !isPasswordEditing {
                if indexPath.row > 2 && indexPath.row <= 5 {
                    return 0
                }
            }
            if !isPasswordEditing && !isEmailEditing {
                if indexPath.row == 6 {
                    return 0
                }
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([EMAIL_SAC])
        
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebViewSegue" {
            let viewController = segue.destination as! WebView
            viewController.textTitle = "Termos de Uso"
            
            let url = URL(string: Repository.getPListValue(.services, key: "useTerms"))
            viewController.selectedURL = url
        }
    }
}
