//
//  CartView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/20/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class CartView: UITableViewController {
    @IBOutlet var viewEmptyCart: UIView!
    
    var messageErrorView : MessageErrorView!
    
    var arrayCart = [[Referencias]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadView()
    }
    
    func reloadView() {
        arrayCart = MarketPlaceController.splitReferencesByPartners(MarketPlaceController.sharedInstance.cartProductsReferences)
        
        showCartMessage()
        
        self.tableView.reloadData()
    }
    
    func showCartMessage() {
        viewEmptyCart.removeFromSuperview()
        
        if MarketPlaceController.sharedInstance.cartProductsReferences.count == 0 {
            self.messageErrorView.updateView("Você não adicionou nenhum produto ao carrinho.")
            
            viewEmptyCart.center = CGPoint(x: self.view.center.x, y: self.view.center.y - viewEmptyCart.frame.height/2)
            
            self.view.addSubview(viewEmptyCart)
        } else {
            self.messageErrorView.updateView("")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return arrayCart.count
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let removeItem = UITableViewRowAction(style: .normal, title: "Remover") { (action, indexPath) -> Void in
            if (indexPath.row * self.arrayCart.count) < MarketPlaceController.sharedInstance.cartProductsReferences.count {
                MarketPlaceController.sharedInstance.cartProductsReferences.remove(at: (indexPath.row * self.arrayCart.count))
                
                self.reloadView()
            }
        }
        
        removeItem.backgroundColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
        
        let editItem = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) -> Void in
            
        }
        
        editItem.backgroundColor = UIColor.colorFrom(hex: COLOR_BLUE_HEX)
        
        return [removeItem, editItem]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageErrorSegue" {
            messageErrorView = segue.destination as! MessageErrorView
        }
    }
}
