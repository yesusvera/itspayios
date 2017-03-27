//
//  UserRegister.swift
//  Itspay
//
//  Created by Junior Braga on 26/02/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit
import PickerFieldsDataHelper

class UserRegisterView: UITableViewController, PickerFieldsDataHelperDelegate, CardIOPaymentViewControllerDelegate {
    
    @IBOutlet weak var labelErrorCardNumber: UILabel!
    @IBOutlet weak var labelErrorBirthday: UILabel!
    @IBOutlet weak var labelErrorCPF: UILabel!
    @IBOutlet weak var labelErrorCelular: UILabel!
    
    @IBOutlet weak var textFieldBirthday: UITextField!
    @IBOutlet weak var textFieldCPF: TextFieldCPFMask!
    @IBOutlet weak var textFieldCelular: UITextField!
    @IBOutlet weak var textFieldCardNumber: TextFieldCardNumberMask!
    
    @IBOutlet weak var buttonCameraValue: UIButton!
    
    let pickerFieldsDataHelper = PickerFieldsDataHelper()
    
    var cardNumber : String!
    var numberPhone : String!
    var birthday : String!
    var cpf : String!
    var password : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        self.title = "Cadastro Login"
        
        
        CardIOUtilities.preloadCardIO()
        
        pickerFieldsDataHelper.delegate = self
        
        pickerFieldsDataHelper.addDataHelpers([textFieldBirthday], isDateType: true)
        
        pickerFieldsDataHelper.doneButtonTitle = "OK"
        pickerFieldsDataHelper.initWithTodayDate = true
    }
    
    func configureView(){
        buttonCameraValue.tintColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorCardNumber.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorBirthday.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorCPF.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        labelErrorCelular.textColor = UIColor.colorFrom(hex:COLOR_BUTTON_PRINCIPAL_HEX)
        
    }
    
    
    @IBAction func buttonDoLoginAction(_ sender: UIButton) {
        if isFormValid() {
            
            self.performSegue(withIdentifier: "RequestToken", sender: self)
            
        }
        
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
        var ErrorPhoneNumber = false
        
        labelErrorCardNumber.isHidden = false
        labelErrorBirthday.isHidden = false
        labelErrorCPF.isHidden = false
        labelErrorCelular.isHidden = false
        
        var cadastro : CadastroSingleton = CadastroSingleton.sharedInstance
        
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
        guard let phoneNumber = textFieldCelular.text else {
            labelErrorCelular.text = "Número Invalido"
            return false
        }
        
        //Cartao
        if cardNumberForm.isEmptyOrWhitespace() || !cardNumberForm.isCardNumber() {
            ErrorCardNumber = true
        }else{
            cardNumber = cardNumberForm
            ErrorCardNumber = false
            labelErrorCardNumber.isHidden = true
            cadastro.numberCard = cardNumberForm
        }
        
        //Aniversário
        if birthdayForm.isEmptyOrWhitespace() {
            labelErrorBirthday.text = "Data de nascimento vazia."
            ErrorBirthday = true
        } else{
            ErrorBirthday = false
            birthday = birthdayForm
            labelErrorBirthday.isHidden = true
            cadastro.burthday = birthdayForm
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
            cadastro.cpf = cpfForm
        }
        
        //Phone Number
        if phoneNumber.isEmptyOrWhitespace() {
            labelErrorCelular.text = "Número Não pode ser vazio"
            ErrorPhoneNumber = true
        } else{
            ErrorPhoneNumber = false
            numberPhone = phoneNumber
            labelErrorCelular.isHidden = true
            cadastro.celular = phoneNumber.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
        }
        
        /////////////////////////////////////////////////////////////////////////
        
        
        if ErrorCardNumber || ErrorBirthday || ErrorCPF {
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
