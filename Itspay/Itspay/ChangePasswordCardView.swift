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
    
    var cardViewController : UIViewController!
    
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
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
