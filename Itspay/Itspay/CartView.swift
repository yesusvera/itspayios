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
    @IBOutlet weak var labelTotal: UILabel!
    
    @IBOutlet weak var viewFooter: UIView!
    
    var totalPrice = Double(0) {
        didSet {
            labelTotal.text = "\(totalPrice)".formatToCurrencyReal()
        }
    }
    
    var messageErrorView : MessageErrorView!
    
    var arrayCart = [[Referencias]]()
    
    var productPartnerEdit : ProductPartner!
    var productEdit : Produtos!
    var referenceSelected : Referencias!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MarketPlaceController.sharedInstance.referenceEditing = nil
        
        reloadView()
    }
    
    func reloadView() {
        totalPrice = 0
        
        NotificationCenter.default.post(name: NSNotification.Name.init("updateCartBadges"), object: nil)
        
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
            
            viewFooter.isHidden = true
        } else {
            viewFooter.isHidden = false
            
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
            if let productPartner = first.productPartner  {
                return productPartner.nomeParceiro
            }
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
        
        if let label = cell.viewWithTag(2) as? UILabel, let product = reference.product, let value = product.nomeProduto {
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
            
            self.totalPrice += Double(total)
            
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
            let array = self.arrayCart[indexPath.section]
            
            let reference = array[indexPath.row]
            
            if let productPartner = reference.productPartner, let product = reference.product {
                MarketPlaceController.sharedInstance.referenceEditing = reference
                
                self.productPartnerEdit = productPartner
                self.productEdit = product
                
                self.performSegue(withIdentifier: "DetailProductSegue", sender: self)
            }
        }
        
        editItem.backgroundColor = UIColor.colorFrom(hex: COLOR_BLUE_HEX)
        
        return [removeItem, editItem]
    }
    
    @IBAction func buttonContinueAction(_ sender: Button) {
        self.performSegue(withIdentifier: "ShippingFormsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageErrorSegue" {
            messageErrorView = segue.destination as! MessageErrorView
        } else if segue.identifier == "DetailProductSegue" {
            let viewController = segue.destination as! DetailProductView
            viewController.productPartner = productPartnerEdit
            viewController.product = productEdit
        } else if segue.identifier == "ShippingFormsSegue" {
            
        }
    }
}
