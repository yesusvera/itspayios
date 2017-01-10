//
//  ShippingPaymentView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/10/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ShippingPaymentView: UITableViewController {
    @IBOutlet weak var textFieldPrice: TextFieldCurrencyMask!
    @IBOutlet weak var textFieldPassword: UITextField!

    var installmentPayment : InstallmentPayment!
    var productPartner : ProductPartner!
    var address : Address!
    var virtualCard : Credenciais!
    var shippingForm : ShippingForm?
    
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Pagamento"
        
        textFieldPrice.text = "\(MarketPlaceController.sharedInstance.totalPrice)".formatToCurrencyReal()
    }
    
    @IBAction func buttonAction(_ sender: Button) {
        if isPasswordValid() {
            if let value = installmentPayment.quantidadeParcelas {
                let yes = UIAlertAction(title: "Sim", style: .default, handler: { (completion) in
                    self.doPayment()
                })
                
                let no = UIAlertAction(title: "Não", style: .default, handler: { (completion) in
                    
                })
                
                AlertComponent.showAlert(title: "Atenção", message: "Deseja autorizar esta compra no valor de \("\(MarketPlaceController.sharedInstance.totalPrice)".formatToCurrencyReal()) em \(value)x?", actions: [yes, no], viewController: self)
            }
        }
    }
    
    func doPayment() {
        let url = MarketPlaceController.createMakeOrderURLPath()
        
        let parameters = MarketPlaceController.createMakeOrderParameters(productPartner, virtualCard: virtualCard, arrayItens: MarketPlaceController.sharedInstance.cartProductsReferences, address: address, shippingForm: shippingForm, installmentPayment: installmentPayment, password: password)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .post, parameters: parameters) { (dataResponse) in
            LoadingProgress.stopAnimating()
            
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                
            }
            
            if let value = dataResponse.result.value as? Int {
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (completion) in
                    MarketPlaceController.sharedInstance.cartProductsReferences.removeAll()
                    MarketPlaceController.sharedInstance.totalPrice = 0
                    
                    NotificationCenter.default.post(name: NSNotification.Name.init("updateCartBadges"), object: nil)
                    NotificationCenter.default.post(name: NSNotification.Name.init("selectTabBarIndexObsever"), object: 1)
                    
                    guard let _ = self.navigationController?.popToRootViewController(animated: true) else {
                        return
                    }
                })
                
                AlertComponent.showAlert(title: "Successo", message: "Compra realizada com sucesso. Número do pedido gerado: \(value).", actions: [ok], viewController: self)
            }
        }
    }
    
    func isPasswordValid() -> Bool {
        guard let passwordValidation = textFieldPassword.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Senha inválida.", viewController: self)
            return false
        }
        
        if passwordValidation == "" {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Senha inválida.", viewController: self)
            return false
        }
        
        password = passwordValidation
        
        return true
    }
}
