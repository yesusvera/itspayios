//
//  RegisterView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/12/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import PickerFieldsDataHelper

class RegisterView: UITableViewController, PickerFieldsDataHelperDelegate, CardIOPaymentViewControllerDelegate {
    @IBOutlet weak var labelErrorCardNumber: UILabel!
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
    @IBOutlet weak var textFieldCardNumber: TextFieldCardNumberMask!
    
    @IBOutlet weak var switchConfirmationValue: UISwitch!
    
    @IBOutlet weak var buttonCameraValue: UIButton!
    
    let pickerFieldsDataHelper = PickerFieldsDataHelper()
    
    var cardNumber : String!
    var email : String!
    var birthday : String!
    var cpf : String!
    var password : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cadastro"
        
        CardIOUtilities.preloadCardIO()
        
        pickerFieldsDataHelper.delegate = self
        
        pickerFieldsDataHelper.addDataHelpers([textFieldBirthday], isDateType: true)
        
        pickerFieldsDataHelper.doneButtonTitle = "OK"
        pickerFieldsDataHelper.initWithTodayDate = true
    }
    
    @IBAction func buttonDoLoginAction(_ sender: UIButton) {
        if isFormValid() {
            let registerLoginObject = LoginController.createRegisterLoginObject(email, birthday : birthday, cpf: cpf, password: password)
            let url = Repository.createServiceURLFromPListValue(.services, key: "register")
            
            Connection.request(url, method: .post, parameters: registerLoginObject.dictionaryRepresentation(), dataResponseJSON: { (dataResponse) in
                if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                    self.performSegue(withIdentifier: "CardsSegue", sender: self)
                }
            })
        }
    }
    
    @IBAction func buttonCameraAction(_ sender: UIButton) {
        if let paymentViewController = CardIOPaymentViewController.init(paymentDelegate: self) {
            self.present(paymentViewController, animated: true, completion: nil)
        }
    }
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        print("Received card info. Number: \(cardInfo.redactedCardNumber), expiry: \(cardInfo.expiryMonth)/\(cardInfo.expiryYear), cvv: \(cardInfo.cvv)")
        
        textFieldCardNumber.text = cardInfo.redactedCardNumber
        
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func isFormValid() -> Bool {
        labelErrorCardNumber.isHidden = false
        labelErrorBirthday.isHidden = false
        labelErrorCPF.isHidden = false
        labelErrorEmail.isHidden = false
        labelErrorEmailConfirmation.isHidden = false
        labelErrorPassword.isHidden = false
        labelErrorPasswordConfirmation.isHidden = false
        
        guard let cardNumberForm = textFieldCardNumber.text else {
            return false
        }
        
        if cardNumberForm.isEmptyOrWhitespace() || !cardNumberForm.isCardNumber() {
            return false
        }
        
        cardNumber = cardNumberForm
        labelErrorCardNumber.isHidden = true
        
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
        
        if !passwordForm.isPasswordValid(min: 6, max: 30) {
            labelErrorPassword.text = "Senha inválida. A senha deve possuir letras e números e ter entre 8 e 30 caracteres."
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebViewSegue" {
            let viewController = segue.destination as! WebView
            viewController.textTitle = "Termos de Uso"
            
            let url = URL(string: Repository.getPListValue(.services, key: "useTerms"))
            viewController.selectedURL = url
        }
    }
}
