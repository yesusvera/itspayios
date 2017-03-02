//
//  ChangePasswordCardView.swift
//  Itspay
//
//  Created by Junior Braga on 01/03/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ChangePasswordCardView: UITableViewController {
    
    @IBOutlet weak var textFieldCurrentPassword: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldNewPasswordConfirmation: UITextField!
    
    var cardViewController : UITableViewController!
    
    var virtualCard : Credenciais!
    
    var securitySettings : SecuritySettings?
    
    var isUpdateCardPasswordOpen = false
    var isComunicateLostStealingOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Alterar Senha do Cartão"
    }
    
    
    
    //    Action Update Password
    @IBAction func buttonUpdatePasswordAction(_ sender: UIButton) {
        toastNotification()
        customAlertPassword()
    }
    
    
    func showService(){
        let url = CardsController.createChangePinURLPath()
        if (textFieldNewPassword.text?.isEqual(textFieldNewPasswordConfirmation.text))!{
            
            let parameters = CardsController.createGeneratePinChangeParameters( virtualCard , senha: textFieldCurrentPassword.text! , novaSenha: textFieldNewPassword.text!)
            
            LoadingProgress.startAnimatingInWindow()
            Connection.request(url, method: .post, parameters: parameters) { (dataResponse) in
                LoadingProgress.stopAnimating()
                
                if let reponse :Bool? = dataResponse.result.isFailure {
                    
                    let buttonOk = UIAlertAction(title: "OK", style: .default, handler: { (response) in
                        
                        self.textFieldNewPassword.text = ""
                        self.textFieldNewPasswordConfirmation.text = ""
                        self.textFieldCurrentPassword.text = ""
                        
                        self.isUpdateCardPasswordOpen = !self.isUpdateCardPasswordOpen
                        
                        self.tableView.beginUpdates()
                        self.tableView.reloadData()
                        self.tableView.endUpdates()
                        
                    })
                    
                    AlertComponent.showAlert(title: "Sucesso", message: "Senha alterada com sucesso.", actions: [buttonOk], viewController: self)
                    
                }else{
                    AlertComponent.showSimpleAlert(title: "Erro", message: "Erro ao alterar a senha.", viewController: self)
                    
                }
            }
        }else{
            AlertComponent.showSimpleAlert(title: "Erro", message: "Senhas nao condizem.", viewController: self)
        }
    }
    func customAlertPassword(){
        
        let alert = UIAlertController(title: "Alterar Senha",
                                      message: "Para alterar senha do cartão digite a chave de acesso",
                                      preferredStyle: .alert)
        
        // Add 1 textField and customize it
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "digite a nchave de acesso"
            textField.clearButtonMode = .whileEditing
            textField.isSecureTextEntry = true
            textField.enablesReturnKeyAutomatically = true
        }
        
        // Submit button
        let submitAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            print(textField.text!)
            
            
            var password = "123"
            if textField.text == password {
                self.showService()
            }else{
                AlertComponent.showSimpleAlert(title: "Alerta", message: "Senha Invalida", viewController: self)
            }
        })
        
        //New Code
        let submitRequestCode = UIAlertAction(title: "Reenviar Código", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            print(textField.text!)
            
            self.toastNotification()
            self.customAlertPassword()
            
        })
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        alert.addAction(submitRequestCode)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func toastNotification(){
        CustomToastNotification().showNotificationTop(title: "Financial", menssage: "Chave de ascesso é : 123", nameImage: "AppIconFinancial")

    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
