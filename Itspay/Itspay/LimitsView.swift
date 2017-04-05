//
//  LimitsView.swift
//  Itspay
//
//  Created by Junior Braga on 05/04/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class LimitsView : UITableViewController{
    
    @IBOutlet weak var limitTotal: UILabel!
    
    @IBOutlet weak var limitsAvailable: UILabel!
    
    var virtualCard : Credenciais!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if virtualCard != nil {
            
            if let value = virtualCard.saldo {
                limitsAvailable.text = "\(value)".formatToCurrencyReal()
            }
            
            if let value = virtualCard.limite {
                limitTotal.text = "\(value)".formatToCurrencyReal()
            }
            
            //            limitTotal.text = String(describing: virtualCard.limite).formatToCurrencyReal()
            
            //            limitsAvailable.text = String(describing: virtualCard.saldo).formatToCurrencyReal()
            
        }
        
        
    }
}
