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

    var virtualCard : Credenciais!
    
    var generatedVirtualCard : NewVirtualCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Cartão Virtual"
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        guard let cardName = textFieldCardName.text else {
            AlertComponent.showSimpleAlert(title: "Erro", message: "Nome para o cartão inválido.", viewController: self)
            
            return
        }
        
        let url = CardsController.createNewVirtualCardURLPath(virtualCard)
        
        let parameters = CardsController.createNewVirtualCardParameters(virtualCard, cardName: cardName, months: segmentedControlValue.selectedSegmentIndex+1)
        
        Connection.request(url, method: .post, parameters: parameters, dataResponseJSON: { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let value = dataResponse.result.value {
                    self.generatedVirtualCard = NewVirtualCard(object: value)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (result) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                    AlertComponent.showAlert(title: "Sucesso", message: "Novo cartão virtual foi gerado.", actions: [okAction], viewController: self)
                }
            }
        })
    }
}
