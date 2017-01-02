//
//  ProductReferencesView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/1/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ProductReferencesView: UITableViewController {
    var product : Produtos!
    
    var amount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Referência"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let categorias = product.categorias {
            if let first = categorias.first {
                return first.descricao
            }
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = product.referencias {
            return array.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductReferencesCellIdentifier", for: indexPath)

        let reference = product.referencias![indexPath.row]
        
        if let label = cell.viewWithTag(1) as? UILabel, let name = product.nomeProduto, let array = reference.caracteristicas {
            var text = name
            
            for object in array {
                if let valor = object.valor {
                    text += " \(valor)"
                }
            }
            
            label.text = text
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reference = product.referencias![indexPath.row]
    
        reference.quantidade = amount
        
        MarketPlaceController.addProductReferenceToCart(reference)
        
        NotificationCenter.default.post(name: NSNotification.Name.init("updateCartBadges"), object: nil)
        
        guard let _ = self.navigationController?.popToRootViewController(animated: true) else {
            return
        }
    }
}
