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
        
        if let first = MarketPlaceController.sharedInstance.cartProductsReferences.first {
            reference = first
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddressChooseSegue" {
            let viewController = segue.destination as! AddressChooseView
            if let productPartner = reference.productPartner {
                viewController.productPartner = productPartner
            }
        } else if segue.identifier == "ShippingChooseCardSegue" {
            let viewController = segue.destination as! ShippingChooseCardView
            viewController.productPartner = reference.productPartner!
            viewController.address = MarketPlaceController.getProductPartnerAddress(reference.productPartner!)
        }
    }
}
