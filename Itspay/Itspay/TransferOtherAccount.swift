//
//  TransferOtherAccount.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/22/16.
//  Copyright © 2016 Compilab. All rights reserved.
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
    
    let pickerFieldsDataHelper = PickerFieldsDataHelper()
    
    var virtualCard : Credenciais!
    
    var tariffProfile = Double(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerFieldsDataHelper.delegate = self
        
        pickerFieldsDataHelper.addDataHelpers([textFieldBank], isDateType: false)
        
        pickerFieldsDataHelper.doneButtonTitle = "OK"
        
        updateViewInfo()
        getTariffProfile()
        getBanksList()
    }
    
    func updateViewInfo() {
        if let object = virtualCard.nomeImpresso {
            textFieldName.text = "\(object)"
        }

        if let object = LoginController.sharedInstance.loginResponseObject.cpf {
            textFieldCPF.text = "\(object)"
        }

        if let object = virtualCard.saldo {
            textFieldPrice.text = "\(object)"
        }
        
        textFieldTariff.text = "\(tariffProfile)".formatToLocalCurrency()
    }
    
    func getTariffProfile() {
        let url = CardsController.createTariffProfileURLPath(virtualCard, tarifa: ID_TARIFAS_TRANSFERENCIA_OTHER_BANK)
        
        Connection.request(url, method: .get, parameters: nil) { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? Double {
                    self.tariffProfile = value
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
        
    }
}
