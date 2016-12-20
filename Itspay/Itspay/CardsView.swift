//
//  CardsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/12/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class CardsView: UITableViewController {
    var arrayVirtualCards = [Credenciais]()
    
    var selectedVirtualCard : Credenciais!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVirtualCards()
    }
    
    func getVirtualCards() {
        if Repository.isMockOn() {
            for i in 1...4 {
                let virtualCardsJSON = Repository.getPListValue(.mocks, key: "virtualCards\(i)")
                
                let credenciais = Credenciais(object: virtualCardsJSON)
                
                credenciais.saldo = Int(arc4random_uniform(100000) + 1)
                credenciais.nomeImpresso = "Virtual Card \(i)"
                credenciais.urlImagemProduto = "Card\(i)"
                
                arrayVirtualCards.append(credenciais)
            }
            
            self.tableView.reloadData()
        } else {
            let url = CardsController.createVirtualCardsURLPath()
            
            Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
                if validateDataResponse(dataResponse, viewController: self) {
                    if let value = dataResponse.result.value as? NSDictionary {
                        if let array = value["credenciais"] as? [Any] {
                            for object in array {
                                let credenciais = Credenciais(object: object)
                            
                                self.arrayVirtualCards.append(credenciais)
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            })
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayVirtualCards.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsCellIdentifier", for: indexPath)

        let virtualCard = arrayVirtualCards[indexPath.row]
        
        if let imageView = cell.viewWithTag(1) as? UIImageView, let value = virtualCard.urlImagemProduto {
            if Repository.isMockOn() {
                imageView.image = UIImage(named: value)
            } else {
//                Connection.imageFrom(value, downloadResponseData: { (response) in
//                    if let data = response.result.value {
//                        imageView.image = UIImage(data: data)
//                    }
//                })
                imageView.image = UIImage(named: "Card\(indexPath.row+1)")
            }
        }
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = virtualCard.saldo {
            label.text = "\(value)".formatToCurrencyReal()
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = virtualCard.nomeImpresso {
            label.text = "\(value)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVirtualCard = arrayVirtualCards[indexPath.row]
        
        self.performSegue(withIdentifier: "DetailCardsSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailCardsSegue" {
            let viewController = segue.destination as! DetailCardsView
            viewController.virtualCard = selectedVirtualCard
        }
    }
}
