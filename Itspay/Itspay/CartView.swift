//
//  CartView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/20/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class CartView: UITableViewController {
    var messageErrorView : MessageErrorView!
    
    var arrayCart = [[Referencias]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrayCart = MarketPlaceController.splitReferencesByPartners(MarketPlaceController.sharedInstance.cartProductsReferences)
        
        showCartMessage()
    }
    
    func showCartMessage() {
        if MarketPlaceController.sharedInstance.cartProductsReferences.count == 0 {
            self.messageErrorView.updateView("Você não adicionou nenhum produto ao carrinho.")
        } else {
            self.messageErrorView.updateView("")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrayCart.count
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if MarketPlaceController.sharedInstance.cartProductsReferences.count == 0 {
            return 0
        }
        return SCREEN_HEIGHT
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = arrayCart[section]
        
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let array = arrayCart[section]
        
        if let first = array.first {
            return first.nomeParceiro
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCellIdentifier", for: indexPath)
        
        let array = arrayCart[indexPath.section]
        
        let reference = array[indexPath.row]
        
        if let imageView = cell.viewWithTag(1) as? UIImageView, let value = reference.idImagem {
            MarketPlaceController.getProduct(with: value, in: imageView, showLoading: true)
        }
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = reference.nomeProduto {
            label.text = "\(value)"
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = reference.precoPor {
            label.text = "\(value)".formatToCurrencyReal()
        }
        
        if let label = cell.viewWithTag(4) as? UILabel, let value = reference.quantidade {
            label.text = "\(value)"
        }
        
        if let label = cell.viewWithTag(5) as? UILabel, let value = reference.quantidade, let object = reference.precoPor {
            let total = Float(value) * object
                
            label.text = "\(total)".formatToCurrencyReal()
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageErrorSegue" {
            messageErrorView = segue.destination as! MessageErrorView
        }
    }
}
