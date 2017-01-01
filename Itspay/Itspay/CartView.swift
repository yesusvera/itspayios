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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if MarketPlaceController.sharedInstance.cartProductsReferences.count == 0 {
            return 0
        }
        return SCREEN_HEIGHT
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MarketPlaceController.sharedInstance.cartProductsReferences.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCellIdentifier", for: indexPath)
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MessageErrorSegue" {
            messageErrorView = segue.destination as! MessageErrorView
        }
    }
}
