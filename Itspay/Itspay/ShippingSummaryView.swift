//
//  ShippingSummaryView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/10/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ShippingSummaryView: UITableViewController {
    @IBOutlet weak var labelProductPartner: UILabel!
    
    @IBOutlet weak var labelShippingForm: UILabel!
    @IBOutlet weak var labelShippingPrice: UILabel!
    @IBOutlet weak var labelShippingAddress: UILabel!
    
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelUserCard: UILabel!
    
    @IBOutlet weak var labelPaymentAmount: UILabel!
    @IBOutlet weak var labelPaymentPrice: UILabel!
    
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    var installmentPayment : InstallmentPayment!
    var productPartner : ProductPartner!
    var address : Address!
    var virtualCard : Credenciais!
    var shippingForm : ShippingForm?
    
    var shippingItemView : ShippingItemView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Resumo"
        
        updateViewInfo()
    }
    
    func updateViewInfo() {
        if let value = productPartner.nomeParceiro {
            labelProductPartner.text = "\(value)"
        }
        
        if let shippingForm = shippingForm {
            if let value = shippingForm.titulo {
                labelShippingForm.text = "\(value)"
            }
            if let value = shippingForm.valor {
                labelShippingPrice.text = "\(value)".formatToCurrencyReal()
            }
        } else {
            labelShippingForm.text = "Retirar na loja"
            labelShippingPrice.text = ""
        }
        
        labelShippingAddress.text = address.fullDescription()
        
        if let value = virtualCard.nomeImpresso {
            labelUsername.text = "\(value)"
        }
        if let value = virtualCard.credencialUltimosDigitos {
            labelUserCard.text = "\(value)"
        }
        if let value = installmentPayment.quantidadeParcelas {
            labelPaymentAmount.text = "\(value)x"
        }
        if let value = installmentPayment.valorParcela {
            labelPaymentPrice.text = "\(value)".formatToCurrencyReal()
        }
        if let value = installmentPayment.valorFinal {
            labelTotalPrice.text = "\(value)".formatToCurrencyReal()
        }
        
        shippingItemView.arrayCartProducts = MarketPlaceController.sharedInstance.cartProductsReferences
        shippingItemView.height = 0
        shippingItemView.tableView.reloadData()
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return shippingItemView.height
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ShippingPaymentSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShippingItemSegue" {
            shippingItemView = segue.destination as! ShippingItemView
        } else if segue.identifier == "ShippingPaymentSegue" {
            let viewController = segue.destination as! ShippingPaymentView
            viewController.installmentPayment = installmentPayment
            viewController.productPartner = productPartner
            viewController.address = address
            viewController.virtualCard = virtualCard
            viewController.shippingForm = shippingForm
        }
    }
}
