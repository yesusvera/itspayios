//
// TransferOtherAccount.swift
// Itspay
//
// Created by Arthur Augusto Sousa Marques on 12/22/16.
// Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import PickerFieldsDataHelper

class TransferOtherAccount: UITableViewController, PickerFieldsDataHelperDelegate {
    @IBOutlet weak var textFieldBank: UITextField!
    @IBOutlet weak var textFieldAgency: UITextField!
    @IBOutlet weak var textFieldAccount: UITextField!
    @IBOutlet weak var textFieldCPF: TextFieldCPFMask!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var textFieldTariff: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var cardViewController : UIViewController!
    
    let pickerFieldsDataHelper = PickerFieldsDataHelper()
    
    var virtualCard : Credenciais!
    
    var tariffProfile = Double(0)
    
    var agency = ""
    var account = ""
    var idBank = 0
    var price = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerFieldsDataHelper.delegate = self
        
        pickerFieldsDataHelper.doneButtonTitle = "OK"
        
        pickerFieldsDataHelper.addDataHelpers([textFieldBank], isDateType: false)
        
        updateViewInfo()
        getTariffProfile()
        getBanksList()
        
        textFieldCPF.text = LoginController.sharedInstance.loginResponseObject.cpf?.cpfFormatted()
        textFieldCPF.endEditing(false)
        textFieldCPF.isUserInteractionEnabled = false
    }
    
    func updateViewInfo() {
        
        if let object = virtualCard.nomeImpresso {
            textFieldName.text = "\(object)"
        }
        
        textFieldTariff.text = "R$ "+"\(tariffProfile)".formatToLocalCurrency()
    }
    
    func getTariffProfile() {
        let url = CardsController.createTariffProfileURLPath(virtualCard, tarifa: ID_TARIFAS_TRANSFERENCIA_OTHER_BANK)
        
        Connection.request(url, method: .get, parameters: nil) { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? Double {
                    self.tariffProfile = value
                    
                    self.updateViewInfo()
                }
            }
        }
    }
    
    func getBanksList() {
        let url = CardsController.createBanksListURLPath()
        
        Connection.request(url, method: .get, parameters: nil) { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? [Any] {
                    for object in value {
                        let bank = Bank(object: object)
                        
                        if let title = bank.descBanco {
                            self.pickerFieldsDataHelper.addTitleAndObjectInDataHelper(self.textFieldBank, title: title, object: bank)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func buttonTransferAction(_ sender: UIButton) {
        if isFormValid() {
            let btnConfirmTransferOK = UIAlertAction(title: "Sim", style: .default, handler: { (response) in
                
                let url = CardsController.createBankTransferURLPath()
                
                let parameters = CardsController.createBankTransferParameters(self.virtualCard, contaCorrenteDestino: self.account, idAgenciaDestino: Int(self.agency)!, idBancoDestino: self.idBank, pinCredencialOrigem: self.textFieldPassword.text!, valorTransferencia: self.price)
                
                LoadingProgress.startAnimatingInWindow()
                Connection.request(url, method: .post, parameters: parameters, dataResponseJSON: { (dataResponse) in
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
                        let message = getDataResponseMessage(dataResponse)
                        AlertComponent.showSimpleAlert(title: "Erro", message: message , viewController: self)
                        
                    }
                })
                
            })
            
            let btnConfirmTransferErro = UIAlertAction(title: "Não", style: .default, handler: { (response) in
                
            })
            
            AlertComponent.showAlert(title: "Atenção", message: "Você deseja completar a Transferencia?", actions: [btnConfirmTransferOK ,btnConfirmTransferErro], viewController: self)
        } else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "* Preencha todos os campos obrigatórios.", viewController: self)
        }
    }
    
    func isFormValid() -> Bool {
        guard let agencyValidation = textFieldAgency.text else {
            return false
        }
        
        if agencyValidation == "" {
            return false
        }
        
        agency = agencyValidation
        
        guard let accountValidation = textFieldAccount.text else {
            return false
        }
        
        if accountValidation == "" {
            return false
        }
        
        account = accountValidation.replacingOccurrences(of: "-", with: "")
        
        guard let bank = pickerFieldsDataHelper.selectedObjectForTextField(textFieldBank) as? Bank else {
            return false
        }
        
        guard let idBankValidation = bank.idBanco else {
            return false
        }
        
        idBank = idBankValidation
        
        guard let priceValidation = textFieldPrice.text else {
            return false
        }
        
        if priceValidation == "" {
            return false
        }
        price = Double(priceValidation.formatToLocalCurrency().replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: ""))!
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let value = virtualCard.saldo {
            return "Saldo: \("\(value)".formatToCurrencyReal())"
        }
        
        return super.tableView(tableView, titleForHeaderInSection: section)
    }
    
}
