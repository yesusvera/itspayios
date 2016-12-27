//
//  ChargeView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/26/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class ChargeView: UITableViewController {
    @IBOutlet weak var textFieldPrice: TextFieldCurrencyMask!
    @IBOutlet weak var textFieldTariff: TextFieldCurrencyMask!
    
    @IBOutlet weak var textFieldResultPrice: TextFieldCurrencyMask!
    @IBOutlet weak var textFieldResultDate: UITextField!
    
    @IBOutlet weak var textViewBarCode: UITextView!
    
    @IBOutlet weak var buttonValue: UIButton!
    
    var ticket : Ticket?
    
    var virtualCard : Credenciais!
    
    var tariffProfile = Double(0)
    
    var price = ""
    
    var barCode = ""
    
    var isTicketGenerated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViewInfo()
        
        getTariffProfile()
    }
    
    func updateViewInfo() {
        self.title = "Inserir Carga"
        
        textFieldTariff.text = "\(tariffProfile)".formatToCurrencyReal()
    }
    
    func updateViewTicketGenerated() {
        self.title = "Carga Inserida"
        
        textFieldResultPrice.text = price
        
        if let ticket = self.ticket {
            if let value = ticket.dataVencimentoFmtMes {
                textFieldResultDate.text = "\(value)"
            }
            
            if let value = ticket.linhaDigitavel {
                textViewBarCode.text = "\(value)"
                
                barCode = value
            }
        }
        
        buttonValue.isHidden = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.shareAction(_:)))
        
        self.tableView.reloadData()
    }
    
    func shareAction(_ sender : Any) {
        let objectsToShare = [barCode]
        
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func getTariffProfile() {
        let url = CardsController.createTariffProfileURLPath(virtualCard, tarifa: ID_TARIFAS_CHARGE)
        
        Connection.request(url, method: .get, parameters: nil) { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? Double {
                    self.tariffProfile = value
                    
                    self.updateViewInfo()
                }
            }
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if isFormValid() {
            let url = CardsController.createGenerateTicketChargeURLPath()
            
            let parameters = CardsController.createGenerateTicketChargeParameters(virtualCard, price : price)
            
            LoadingProgress.startAnimatingInWindow()
            Connection.request(url, method: .post, parameters: parameters) { (dataResponse) in
                LoadingProgress.stopAnimating()
                if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                    if let value = dataResponse.result.value {
                        self.isTicketGenerated = true
                        
                        self.ticket = Ticket(object: value)
                        
                        self.updateViewTicketGenerated()
                    }
                }
            }
        }
    }
    
    func isFormValid() -> Bool {
        guard let priceValidation = textFieldPrice.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Valor inválido.", viewController: self)
            return false
        }
        
        price = priceValidation
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isTicketGenerated {
            if indexPath.row > 1 {
                return 0
            }
        } else {
            if indexPath.row <= 1 {
                return 0
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if !isTicketGenerated {
            if let value = virtualCard.saldo {
                return "Saldo: \("\(value)".formatToCurrencyReal())"
            }
            
            return nil
        }
        
        return super.tableView(tableView, titleForHeaderInSection: section)
    }
}
