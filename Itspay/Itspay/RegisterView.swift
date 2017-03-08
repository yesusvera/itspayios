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
    var switchBollean = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congigureView()
        
        self.title = "Cadastro Login"
        
        CardIOUtilities.preloadCardIO()
        
        pickerFieldsDataHelper.delegate = self
        
        pickerFieldsDataHelper.addDataHelpers([textFieldBirthday], isDateType: true)
        
        pickerFieldsDataHelper.doneButtonTitle = "OK"
        pickerFieldsDataHelper.initWithTodayDate = true
    }
    
    func congigureView(){
        switchConfirmationValue.onTintColor =  UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorCardNumber.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorBirthday.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorCPF.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorEmail.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorEmailConfirmation.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorPassword.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorPasswordConfirmation.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        buttonCameraValue.tintColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
    }
    

    @IBAction func aceptTerms(_ sender: UISwitch) {
        switchBollean = sender.isOn
    }
    @IBAction func buttonDoLoginAction(_ sender: UIButton) {
        if isFormValid() {
            if switchBollean {
               
                let registerLoginObject = LoginController.createRegisterLoginObject(email, birthday : GetDateFromString(DateStr: birthday), cpf: cpf, password: password, cardNumber: cardNumber)
                
                let url = Repository.createServiceURLFromPListValue(.services, key: "register")
            
                Connection.request(url, method: .post, parameters: registerLoginObject){ (dataResponse) in
                    if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                        self.performSegue(withIdentifier: "CardsSegue", sender: self)
                    }
                }
        
            }else{
                AlertComponent.showSimpleAlert(title: "Atenção", message: "Aceite os termos para criar login ", viewController: self)
            }
        }
    }
    
    func GetDateFromString(DateStr: String)-> String {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let DateArray = DateStr.components(separatedBy: "/")
        let components = NSDateComponents()
        components.year = Int(DateArray[2])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[0])!
        
        let date = calendar?.date(from: components as DateComponents)
        
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd"
        
        let stringOfDate = dateFormate.string(from: date!)
        print(stringOfDate)
        
        return stringOfDate
    }
    
    @IBAction func buttonCameraAction(_ sender: UIButton) {
        if let paymentViewController = CardIOPaymentViewController.init(paymentDelegate: self) {
            paymentViewController.useCardIOLogo = true
            paymentViewController.hideCardIOLogo = true
            paymentViewController.navigationBarTintColor = UIColor.colorFrom(hex: COLOR_NAVIGATION_BAR_HEX)
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
        var ErrorCardNumber = false
        var ErrorBirthday = false
        var ErrorCPF = false
        var ErrorEmail = false
        var ErrorEmailConfirmation = false
        var ErrorPassword = false
        var ErrorPasswordConfirmation = false
        
        labelErrorCardNumber.isHidden = false
        labelErrorBirthday.isHidden = false
        labelErrorCPF.isHidden = false
        labelErrorEmail.isHidden = false
        labelErrorEmailConfirmation.isHidden = false
        labelErrorPassword.isHidden = false
        labelErrorPasswordConfirmation.isHidden = false
        
        //guards
        guard let cardNumberForm = textFieldCardNumber.text else {
            return false
        }
        guard let birthdayForm = textFieldBirthday.text else {
            labelErrorBirthday.text = "Data de nascimento vazia."
            return false
        }
        guard let cpfForm = textFieldCPF.text else {
            labelErrorCPF.text = "CPF vazio."
            return false
        }
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
        
        //Cartao
        if cardNumberForm.isEmptyOrWhitespace() || !cardNumberForm.isCardNumber() {
            ErrorCardNumber = true
        }else{
            cardNumber = cardNumberForm
            ErrorCardNumber = false
            labelErrorCardNumber.isHidden = true
        }
        
        //Aniversário
        if birthdayForm.isEmptyOrWhitespace() {
            labelErrorBirthday.text = "Data de nascimento vazia."
            ErrorBirthday = true
        } else{
            ErrorBirthday = false
            birthday = birthdayForm
            labelErrorBirthday.isHidden = true
        }
        
        //CPF
        let cpfValidation = cpfForm.isCPFValid()
        
        if cpfForm.isEmptyOrWhitespace() {
            labelErrorCPF.text = "CPF vazio."
            ErrorCPF = true
        }else if !cpfValidation.value {
            labelErrorCPF.text = cpfValidation.message
            ErrorCPF = true
        }else{
            ErrorCPF = false
            cpf = cpfForm
            labelErrorCPF.isHidden = true
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
        }
        
        /////////////////////////////////////////////////////////////////////////
        
        
        if ErrorCardNumber || ErrorBirthday || ErrorCPF || ErrorEmail || ErrorEmailConfirmation ||
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
