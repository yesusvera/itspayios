//
//  FinishUserLoginView.swift
//  Itspay
//
//  Created by Junior Braga on 28/02/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit
import PickerFieldsDataHelper

class FinishUserLoginView: UITableViewController {
    
    @IBOutlet weak var labelErrorEmail: UILabel!
    @IBOutlet weak var labelErrorEmailConfirmation: UILabel!
    @IBOutlet weak var labelErrorPassword: UILabel!
    @IBOutlet weak var labelErrorPasswordConfirmation: UILabel!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldEmailConfirmation: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldPasswordConfirmation: UITextField!
    
    @IBOutlet weak var switchConfirmationValue: UISwitch!
    
    
    
    let pickerFieldsDataHelper = PickerFieldsDataHelper()
    
    var email : String!
    var password : String!
    var switchBollean = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        self.title = "Cadastro Login"
    }
    
    func configureView(){
        switchConfirmationValue.onTintColor =  UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorEmail.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorEmailConfirmation.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorPassword.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorPasswordConfirmation.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
    }
    
    
    @IBAction func aceptTerms(_ sender: UISwitch) {
        switchBollean = sender.isOn
    }
    @IBAction func buttonDoLoginAction(_ sender: UIButton) {
        if isFormValid() {
            if switchBollean {
                let registerLoginObject = LoginController.createRegisterLoginObject()
                let url = Repository.createServiceURLFromPListValue(.services, key: "register")
                
                Connection.request(url, method: .post, parameters: registerLoginObject, dataResponseJSON: { (dataResponse) in
                    if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                        self.performSegue(withIdentifier: "CardsSegue", sender: self)
                    }
                })
                
            }else{
                AlertComponent.showSimpleAlert(title: "Atenção", message: "Aceite os termos para criar login ", viewController: self)
            }
        }
    }
    
    
    func isFormValid() -> Bool {
        var ErrorEmail = false
        var ErrorEmailConfirmation = false
        var ErrorPassword = false
        var ErrorPasswordConfirmation = false
        
        labelErrorEmail.isHidden = false
        labelErrorEmailConfirmation.isHidden = false
        labelErrorPassword.isHidden = false
        labelErrorPasswordConfirmation.isHidden = false
        
        var cadastro : CadastroSingleton = CadastroSingleton.sharedInstance
        
        
        guard let emailForm = textFieldEmail.text else {
            labelErrorEmail.text = "Email vazio."
            return false
        }
        guard let emailConfirmation = textFieldEmailConfirmation.text else {
            labelErrorEmailConfirmation.text = "Confirmação de Email vazia."
            return false
        }
        guard let passwordForm = textFieldPassword.text else {
            labelErrorPassword.text = "Senha vazia."
            return false
        }
        
        guard let passwordConfirmation = textFieldPasswordConfirmation.text else {
            labelErrorPasswordConfirmation.text = "Confirmação de Senha vazia."
            return false
        }
        
        //Email
        if emailForm.isEmptyOrWhitespace() {
            ErrorEmail = true
            labelErrorEmail.text = "Email vazio."
        }else if !emailForm.isEmail() {
            ErrorEmail = true
            labelErrorEmail.text = "Email inválido."
        }else{
            ErrorEmail = false
            labelErrorEmail.isHidden = true
        }
        
        //Confima Email
        if emailConfirmation.isEmptyOrWhitespace() {
            labelErrorEmailConfirmation.text = "Confirmação de Email vazia."
            ErrorEmailConfirmation = true
        }else if emailForm != emailConfirmation {
            labelErrorEmailConfirmation.text = "Confirmação de Email inválida."
            ErrorEmailConfirmation = true
        }else{
            email = emailForm
            labelErrorEmailConfirmation.isHidden = true
            ErrorEmailConfirmation = false
            cadastro.email = email
        }
        
        //Senha
        if !passwordForm.isPasswordValid(min: 6, max: 30) {
            labelErrorPassword.text = "Senha inválida. A senha deve possuir letras e números e ter entre 8 e 30 caracteres."
            ErrorPassword = true
        }else{
            labelErrorPassword.isHidden = true
            ErrorPassword = false
        }
        
        //Conrifme Senha
        if passwordConfirmation.isEmptyOrWhitespace() {
            labelErrorPasswordConfirmation.text = "Confirmação de Senha vazia."
            ErrorPasswordConfirmation = true
        }else if passwordForm != passwordConfirmation {
            labelErrorPasswordConfirmation.text = "Confirmação de Senha inválida."
            ErrorPasswordConfirmation = true
        }else{
            password = passwordForm
            labelErrorPasswordConfirmation.isHidden = true
            ErrorPasswordConfirmation = false
            cadastro.password = password
        }
        
        /////////////////////////////////////////////////////////////////////////
        
        
        if ErrorEmail || ErrorEmailConfirmation ||
            ErrorPassword || ErrorPasswordConfirmation {
            return false
        }else{
            return true
        }
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
