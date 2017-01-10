//
//  ShippingChooseCardView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/9/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ShippingChooseCardView: UITableViewController {
    @IBOutlet weak var errorView: ErrorView!
    
    var productPartner : ProductPartner!
    
    var address : Address!
    
    var shippingForm : ShippingForm?
    
    var myRequest : MyRequest?
    
    var arrayVirtualCards = [Credenciais]()
    
    var selectedVirtualCard : Credenciais!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Escolha o Cartão"
        
        getUnlockedCards()
    }
    
    func getUnlockedCards() {
        let url = CardsController.createUnlockedCardURLPath()
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let value = dataResponse.result.value as? NSDictionary {
                    if let array = value["credenciais"] as? [Any] {
                        self.arrayVirtualCards = [Credenciais]()
                        
                        for object in array {
                            let credenciais = Credenciais(object: object)
                            
                            self.arrayVirtualCards.append(credenciais)
                        }
                        
                        if self.arrayVirtualCards.count == 0 {
                            self.errorView.msgError = "Nenhum cartão encontrado."
                        } else {
                            self.errorView.msgError = ""
                        }
                        
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayVirtualCards.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingChooseCardCellIdentifier", for: indexPath)

        let virtualCard = arrayVirtualCards[indexPath.row]
        
        if let imageView = cell.viewWithTag(1) as? UIImageView {
            if Repository.isMockOn() {
                imageView.image = UIImage(named: "Card\(indexPath.row+1)")
            } else {
                CardsController.openPlastics(virtualCard, in: imageView, showLoading: true)
            }
        }
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = virtualCard.saldo {
            label.text = "\(value)".formatToCurrencyReal()
            
            label.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = virtualCard.nomeImpresso {
            label.text = "\(value)"
            
            label.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        }
        
        if let label = cell.viewWithTag(4) as? UILabel, let value = virtualCard.credencialMascarada {
            label.text = "\(value)"
            
            label.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVirtualCard = arrayVirtualCards[indexPath.row]
        
        self.performSegue(withIdentifier: "InstallmentPaymentChooseSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InstallmentPaymentChooseSegue" {
            let viewController = segue.destination as! InstallmentPaymentChooseView
            viewController.virtualCard = selectedVirtualCard
            viewController.productPartner = productPartner
            viewController.address = address
            viewController.shippingForm = shippingForm
        }
    }
}
