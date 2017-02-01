//
//  TransferFinancialCard.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/22/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class TransferFinancialCard: UITableViewController, TextFieldMaskDelegate {
    @IBOutlet weak var textFieldCardNumber: TextFieldCardNumberMask!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: TextFieldCurrencyMask!
    @IBOutlet weak var textFieldTariff: TextFieldCurrencyMask!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var cardViewController : UIViewController!
    
    var virtualCard : Credenciais!
    
    var carrierInfo : CarrierInfo?
    
    var tariffProfile = Double(0)
    
    var password = ""
    
    var cardNumber = ""
    
    var price = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldCardNumber.textFieldMaskDelegate = self
        
        updateViewInfo()
        getTariffProfile()
    }
    
    func updateViewInfo() {
        
        if let carrierInfo = carrierInfo {
            if let object = carrierInfo.nome {
                textFieldName.text = "\(object)"
            }
        }
        
        textFieldTariff.text = "R$ "+"\(tariffProfile)".formatToLocalCurrency()
    }
    
    func getTariffProfile() {
        let url = CardsController.createTariffProfileURLPath(virtualCard, tarifa: ID_TARIFAS_TRANSFERENCIA_CARD)
        
        Connection.request(url, method: .get, parameters: nil) { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? Double {
                    self.tariffProfile = value
                    
                    self.updateViewInfo()
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == textFieldCardNumber {
            getCarrierInfo()
        }
    }
    
    func getCarrierInfo() {
        if isCardNumberValid() {
            let url = CardsController.createCarrierInfoURLPath()
            
            let parameters = CardsController.createCarrierInfoParameters(cardNumber: textFieldCardNumber.text!.onlyNumbers())
            LoadingProgress.startAnimatingInWindow()
            Connection.request(url, method: .post, parameters: parameters) { (dataResponse) in
                if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                    LoadingProgress.stopAnimating()
                    if let value = dataResponse.result.value {
                        self.carrierInfo = CarrierInfo(object: value)
                        
                        self.updateViewInfo()
                    }
                }
            }
        }
    }
    
    @IBAction func buttonTransferAction(_ sender: UIButton) {
        if isFormValid() {
            let url = CardsController.createCardTransferURLPath()
            
            let parameters = CardsController.createCardTransferParameters(virtualCard, cardNumber: cardNumber, password : password, price: price)
    
                let btnConfirmTransferOK = UIAlertAction(title: "Sim", style: .default, handler: { (response) in
                    LoadingProgress.startAnimatingInWindow()
                    Connection.request(url, method: .post, parameters: parameters)  { (dataResponse) in
                        LoadingProgress.stopAnimating()
                        if !validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                            let message = getDataResponseMessage(dataResponse)
                        
                            if message.lowercased().contains("sucesso") {
                                let buttonOk = UIAlertAction(title: "OK", style: .default, handler: { (response) in
                                    guard let _ = self.navigationController?.popToViewController(self.cardViewController, animated: true) else {
                                        return
                                    }
                                })
                            
                                AlertComponent.showAlert(title: "Sucesso", message: message, actions: [buttonOk], viewController: self)
                            } else {
                                AlertComponent.showSimpleAlert(title: "Erro", message: message, viewController: self)
                            }
                        } else {
                            let _ = validateDataResponse(dataResponse, showAlert: true, viewController: self)
                        }
                    }
                })
        
            let btnConfirmTransferErro = UIAlertAction(title: "Não", style: .default, handler: { (response) in
            
            })
        
            AlertComponent.showAlert(title: "Atenção", message: "Você deseja efetuar a transferência?", actions: [btnConfirmTransferOK ,btnConfirmTransferErro], viewController: self)
            
        }
    }
    
    func isFormValid() -> Bool {
        if !isCardNumberValid() {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Número do Cartão inválido.", viewController: self)
            return false
        }
        
        guard let priceValidation = textFieldPrice.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Valor inválido.", viewController: self)
            return false
        }
        
        if priceValidation == "" {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Valor inválido.", viewController: self)
            return false
        }
        
        price = priceValidation
        
        guard let passwordValidation = textFieldPassword.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Senha inválida.", viewController: self)
            return false
        }
        
        if passwordValidation == "" {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Senha inválida.", viewController: self)
            return false
        }
        
        password = passwordValidation
        
        return true
    }
    
    func isCardNumberValid() -> Bool {
        guard let cardNumberValidation = textFieldCardNumber.text else {
            return false
        }
        
        if cardNumberValidation == "" {
            return false
        }
        
        cardNumber = cardNumberValidation
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let value = virtualCard.saldo {
            return "Saldo: \("\(value)".formatToCurrencyReal())"
        }
        
        return super.tableView(tableView, titleForHeaderInSection: section)
    }

}
