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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Transferências"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TransferFinancialCardSegue" {
            let viewController = segue.destination as! TransferFinancialCard
            viewController.virtualCard = virtualCard
        } else if segue.identifier == "TransferOtherAccountSegue" {
            let viewController = segue.destination as! TransferOtherAccount
            viewController.virtualCard = virtualCard
        }
    }
}
