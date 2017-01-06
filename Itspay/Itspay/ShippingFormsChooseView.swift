//
//  ShippingFormsChooseView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/6/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ShippingFormsChooseView: UITableViewController {
    var address : Address!
    var productPartner : ProductPartner!
    
    var arrayShippingForms = [ShippingForm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Forma de Envio"
        
        getShippingForms()
    }
    
    func getShippingForms() {
        let url = MarketPlaceController.createShippingFormsURLPath(productPartner, address: address)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let array = dataResponse.result.value as? [Any] {
                    self.arrayShippingForms = [ShippingForm]()
                    
                    for object in array {
                        let shippingForm = ShippingForm(object: object)
                        
                        self.arrayShippingForms.append(shippingForm)
                    }
                    
                    self.tableView.reloadData()
                }
            }
        })

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayShippingForms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingFormsChooseCellIdentifier", for: indexPath)

        let shippingForm = arrayShippingForms[indexPath.row]
        
        if let label = cell.viewWithTag(1) as? UILabel, let value = shippingForm.titulo {
            label.text = "\(value)"
        }
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = shippingForm.descricao {
            label.text = "\(value)"
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = shippingForm.valor {
            if value < 0 {
                label.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
            } else {
                label.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
            }
            
            label.text = "\(value)".formatToCurrencyReal()
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
    
