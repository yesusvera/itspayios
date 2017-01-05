//
//  ForgotPassowordView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/4/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ForgotPassowordView: UITableViewController {
    
    @IBOutlet weak var textFieldCPF: TextFieldCPFMask!
    
    @IBOutlet weak var labelErrorCPF: UILabel!
    
    var cpf = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Esqueci a Senha"
    }
    
    @IBAction func buttonRequestAction(_ sender: UIButton) {
        if isFormValid() {
            let url = Repository.createServiceURLFromPListValue(.services, key: "recoverPassword")
            
            let parameters = LoginController.createRecoverPasswordParameters(cpf)
            
            Connection.request(url, method: .post, parameters: parameters, dataResponseJSON: { (dataResponse) in
                if !validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                    let message = getDataResponseMessage(dataResponse)
                    
                    AlertComponent.showSimpleAlert(title: "Sucesso", message: message, viewController: self)
                }
            })
        }
    }
    
    func isFormValid() -> Bool {
        labelErrorCPF.isHidden = false
        
        guard let cpfForm = textFieldCPF.text else {
            labelErrorCPF.text = "CPF vazio."
            return false
        }
        
        if cpfForm.isEmptyOrWhitespace() {
            labelErrorCPF.text = "CPF vazio."
            return false
        }
        
        let cpfValidation = cpfForm.isCPFValid()
        
        if !cpfValidation.value {
            labelErrorCPF.text = cpfValidation.message
            return false
        }
        
        cpf = cpfForm
        labelErrorCPF.isHidden = true
        
        return true
    }
}
