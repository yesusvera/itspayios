//
//  InstallmentPaymentChooseView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/9/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class InstallmentPaymentChooseView: UITableViewController {
    var virtualCard : Credenciais!
    
    var productPartner : ProductPartner!
    
    var arrayInstallmentPayments = [InstallmentPayment]()

    var selectedInstallmentPayment : InstallmentPayment!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Parcelamento"
        
        getInstallmentPayments()
    }
    
    func getInstallmentPayments() {
        let url = MarketPlaceController.createInstallmentPaymentURLPath(productPartner)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let value = dataResponse.result.value as? NSDictionary {
                    if let array = value["parcelas"] as? [Any] {
                        self.arrayInstallmentPayments = [InstallmentPayment]()
                        
                        for object in array {
                            let installmentPayment = InstallmentPayment(object: object)
                            
                            self.arrayInstallmentPayments.append(installmentPayment)
                        }

                        self.tableView.reloadData()
                    }
                }
            }
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayInstallmentPayments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstallmentPaymentChooseCellIdentifier", for: indexPath)

        let installmentPayment = arrayInstallmentPayments[indexPath.row]
        
        if let label = cell.viewWithTag(1) as? UILabel, let value = installmentPayment.quantidadeParcelas {
            label.text = "\(value)x"
        }
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = installmentPayment.valorParcela {
            label.text = "\(value)".formatToCurrencyReal()
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = installmentPayment.valorFinal {
            label.text = "\(value)".formatToCurrencyReal()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedInstallmentPayment = arrayInstallmentPayments[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
