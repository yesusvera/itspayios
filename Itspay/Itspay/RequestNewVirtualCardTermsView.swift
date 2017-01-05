//
//  RequestNewVirtualCardTermsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/4/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class RequestNewVirtualCardTermsView: UIViewController {
    var virtualCard : Credenciais!
    
    var generatedVirtualCard : NewVirtualCard!
    
    var requestCardViewController : UIViewController!
    
    var cardName = ""
    var months = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Termos"
    }
    
    @IBAction func buttonRequestAction(_ sender: Button) {
        let url = CardsController.createNewVirtualCardURLPath(virtualCard)
        
        let parameters = CardsController.createNewVirtualCardParameters(virtualCard, cardName: cardName, months: months)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .post, parameters: parameters, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let value = dataResponse.result.value {
                    self.generatedVirtualCard = NewVirtualCard(object: value)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (result) in
                        guard let _ = self.navigationController?.popToViewController(self.requestCardViewController, animated: true) else {
                            return 
                        }
                    })
                    
                    AlertComponent.showAlert(title: "Sucesso", message: "Novo cartão virtual foi gerado.", actions: [okAction], viewController: self)
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebViewSegue" {
            let viewController = segue.destination as! WebView
            
            let url = URL(string: Repository.getPListValue(.services, key: "useTerms"))
            
            viewController.selectedURL = url
        }
    }
}
