//
//  TransferFinancialCard.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/22/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class TransferFinancialCard: UITableViewController {
    @IBOutlet weak var textFieldCardNumber: TextFieldCardNumberMask!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: TextFieldCurrencyMask!
    @IBOutlet weak var textFieldTariff: TextFieldCurrencyMask!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var virtualCard : Credenciais!
    
    var tariffProfile = Double(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewInfo()
        getTariffProfile()
    }
    
    func updateViewInfo() {
        if let object = virtualCard.nomeImpresso {
            textFieldName.text = "\(object)"
        }
        
        if let object = virtualCard.saldo {
            textFieldPrice.text = "\(object)".formatToCurrencyReal()
        }
        
        textFieldTariff.text = "\(tariffProfile)".formatToLocalCurrency()
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
    
    @IBAction func buttonTransferAction(_ sender: UIButton) {
        
    }
}
