//
//  TransferMainView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/22/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class TransferMainView: UITableViewController {
    var virtualCard : Credenciais!
    
    var cardViewController : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Transferências"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TransferFinancialCardSegue" {
            let viewController = segue.destination as! TransferFinancialCard
            viewController.virtualCard = virtualCard
            viewController.cardViewController = cardViewController
        } else if segue.identifier == "TransferOtherAccountSegue" {
            let viewController = segue.destination as! TransferOtherAccount
            viewController.virtualCard = virtualCard
            viewController.cardViewController = cardViewController
        }
    }
}
