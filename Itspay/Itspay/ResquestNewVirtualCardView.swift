//
//  ResquestNewVirtualCardView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/26/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class ResquestNewVirtualCardView: UITableViewController {
    @IBOutlet weak var textFieldCardName: UITextField!

    @IBOutlet weak var segmentedControlValue: UISegmentedControl!

    var requestCardViewController : UIViewController!
    
    var virtualCard : Credenciais!
    
    var cardName = ""
    var months = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cartão Virtual"
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        guard let cardNameValidation = textFieldCardName.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Nome para o cartão inválido.", viewController: self)
            
            return
        }
        
        cardName = cardNameValidation
        months = segmentedControlValue.selectedSegmentIndex+1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RequestNewVirtualCardTermsSegue" {
            let viewController = segue.destination as! RequestNewVirtualCardTermsView
            viewController.virtualCard = virtualCard
            viewController.requestCardViewController = requestCardViewController
            viewController.cardName = cardName
            viewController.months = months
        }
    }
}
