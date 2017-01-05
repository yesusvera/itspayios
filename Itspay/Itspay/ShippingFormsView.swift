//
//  ShippingFormsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/5/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ShippingFormsView: UITableViewController {
    var reference : Referencias!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Formas de Entrega"
        
        getAddresses()
    }
    
    func getAddresses() {
        let url = MarketPlaceController.createAddressesURLPath()
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let productPartner = reference.productPartner {
            if let value = productPartner.entrega {
                if value == 1 && indexPath.row == 1 {
                    return 0
                }
                if value == 2 && indexPath.row == 0 {
                    return 0
                }
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
