//
//  ProductItemView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/8/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ShippingItemView: UITableViewController {
    var arrayShippingItens = [ItensPedido]()
    var arrayCartProducts = [Referencias]()
    
    var isBuying = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isBuying {
            return arrayCartProducts.count
        }
        return arrayShippingItens.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingItemCellIdentifier", for: indexPath)

        if isBuying {
            let reference = arrayCartProducts[indexPath.row]
            
            if let imageView = cell.viewWithTag(1) as? UIImageView, let value = reference.idImagem {
                MarketPlaceController.getProduct(with: value, in: imageView, showLoading: true)
            }
            
            if let label = cell.viewWithTag(2) as? UILabel, let product = reference.product, let value = product.nomeProduto {
                label.text = "\(value)"
            }
            
            if let label = cell.viewWithTag(3) as? UILabel, let value = reference.quantidade {
                label.text = "\(value)"
            }
            
            if let label = cell.viewWithTag(4) as? UILabel, let value = reference.precoPor {
                label.text = "\(value)".formatToCurrencyReal()
            }
        } else {
            let shippingItem = arrayShippingItens[indexPath.row]
            
            if let imageView = cell.viewWithTag(1) as? UIImageView, let value = shippingItem.idSKU {
                MarketPlaceController.getProduct(with: value, in: imageView, showLoading: true)
            }
            
            if let label = cell.viewWithTag(2) as? UILabel, let value = shippingItem.nomeProduto {
                label.text = "\(value)"
            }
            
            if let label = cell.viewWithTag(3) as? UILabel, let value = shippingItem.quantidadeItem {
                label.text = "\(value)"
            }
            
            if let label = cell.viewWithTag(4) as? UILabel, let value = shippingItem.valorTotalItem {
                label.text = "\(value)".formatToCurrencyReal()
            }
        }
        
        return cell
    }
}
