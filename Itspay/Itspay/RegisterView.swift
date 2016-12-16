//
//  RegisterView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/12/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class RegisterView: UITableViewController, PickerFieldsDataHelperDelegate {
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
    
    let pickerFieldsDataHelper = PickerFieldsDataHelper()
    
    var email : String!
    var birthday : String!
    var cpf : String!
    var password : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cadastro"
        
        textFieldBirthday.isDefaultInputAcessoryViewOn = false
        
        pickerFieldsDataHelper.delegate = self
        
        pickerFieldsDataHelper.addDataHelpers([textFieldBirthday], isDateType: true)
        
        pickerFieldsDataHelper.doneButtonTitle = "OK"
        pickerFieldsDataHelper.initWithTodayDate = true
    }
    
    @IBAction func buttonDoLoginAction(_ sender: UIButton) {
        if isFormValid() {
            let registerLoginObject = LoginController.createRegisterLoginObject(email : email, birthday : birthday, cpf: cpf, password: password)
            let url = Repository.createServiceURLFromPListValue(.services, key: "cadastro")
            
            Connection.request(url, method: .post, parameters: registerLoginObject.dictionaryRepresentation(), dataResponseJSON: { (dataResponse) in
                if validateDataResponse(dataResponse: dataResponse, viewController: self) {
                    let alertView = UIAlertView.init(title: "Sucesso", message: "Login Efetuado.", delegate: self, cancelButtonTitle: "OK")
                    alertView.show()
                }
            })
        }
    }
    
    func isFormValid() -> Bool {
        labelErrorBirthday.isHidden = false
        labelErrorCPF.isHidden = false
        labelErrorEmail.isHidden = false
        labelErrorEmailConfirmation.isHidden = false
        labelErrorPassword.isHidden = false
        labelErrorPasswordConfirmation.isHidden = false
        
        guard let birthdayForm = textFieldCPF.text else {
            labelErrorBirthday.text = "Data de nascimento vazia."
            return false
        }
        
        if birthdayForm.isEmptyOrWhitespace() {
            labelErrorBirthday.text = "Data de nascimento vazia."
            return false
        }
        
        birthday = birthdayForm
        labelErrorBirthday.isHidden = true
        
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
        
        guard let emailForm = textFieldEmail.text else {
            labelErrorEmail.text = "Email vazio."
            return false
        }
        
        if emailForm.isEmptyOrWhitespace() {
            labelErrorEmail.text = "Email vazio."
            return false
        }
        
        if !emailForm.isEmail() {
            labelErrorEmail.text = "Email inválido."
            return false
        }
        
        labelErrorEmail.isHidden = true
        
        guard let emailConfirmation = textFieldEmailConfirmation.text else {
            labelErrorEmailConfirmation.text = "Confirmação de Email vazia."
            return false
        }
        
        if emailConfirmation.isEmptyOrWhitespace() {
            labelErrorEmailConfirmation.text = "Confirmação de Email vazia."
            return false
        }
        
        if emailForm != emailConfirmation {
            labelErrorEmailConfirmation.text = "Confirmação de Email inválida."
            return false
        }
        
        email = emailForm
        labelErrorEmailConfirmation.isHidden = true
        
        guard let passwordForm = textFieldPassword.text else {
            labelErrorPassword.text = "Senha vazia."
            return false
        }
        
        if passwordForm.isEmptyOrWhitespace() {
            labelErrorPassword.text = "Senha vazia."
            return false
        }
        
        labelErrorPassword.isHidden = true
        
        guard let passwordConfirmation = textFieldPasswordConfirmation.text else {
            labelErrorPasswordConfirmation.text = "Confirmação de Senha vazia."
            return false
        }
        
        if passwordConfirmation.isEmptyOrWhitespace() {
            labelErrorPasswordConfirmation.text = "Confirmação de Senha vazia."
            return false
        }
        
        if passwordForm != passwordConfirmation {
            labelErrorPasswordConfirmation.text = "Confirmação de Senha inválida."
            return false
        }
        
        password = passwordForm
        labelErrorPasswordConfirmation.isHidden = true
        
        return true
    }
    
    func pickerFieldsDataHelper(_ dataHelper: PickerDataHelper, didSelectObject selectedObject: AnyObject?, withTitle title: String?) {
        if pickerFieldsDataHelper == dataHelper {
            pickerFieldsDataHelper.refreshDate(dataHelper)
        }
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
