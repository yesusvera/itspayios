//
//  RequestVirtualCardsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/26/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class RequestVirtualCardsView: UITableViewController {
    var arrayVirtualCards = [Credenciais]()
    
    var virtualCard : Credenciais!
    
    var messageErrorView : MessageErrorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Seus Cartões Virtual"
        
        self.refreshControl = UIRefreshControl(frame: CGRect.zero)
        
        self.refreshControl?.addTarget(self, action: #selector(self.getVirtualCardsList), for: .valueChanged)
        
        self.tableView.addSubview(self.refreshControl!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getVirtualCardsList()
    }
    
    func getVirtualCardsList() {
        let url = CardsController.createVirtualCardsListURLPath(virtualCard)
        
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            self.refreshControl?.endRefreshing()
            
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? NSDictionary {
                    if let array = value["credenciais"] as? [Any] {
                        self.arrayVirtualCards = [Credenciais]()
                        
                        for object in array {
                            let virtualCard = Credenciais(object: object)
                            
                            self.arrayVirtualCards.append(virtualCard)
                        }
                        
                        if self.arrayVirtualCards.count == 0 {
                            self.messageErrorView.updateView("Você ainda não possui cartões. Quando solicitá-los, eles aparecerão aqui")
                        } else {
                            self.messageErrorView.updateView("")
                        }
                        
                        self.tableView.reloadData()
                    }
                }
            }
        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayVirtualCards.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestVirtualCardsCellIdentifier", for: indexPath)

        let virtualCard = arrayVirtualCards[indexPath.row]
        
        if let imageView = cell.viewWithTag(1) as? UIImageView {
            if Repository.isMockOn() {
                imageView.image = UIImage(named: "Card\(indexPath.row+1)")
            } else {
                CardsController.openPlastics(virtualCard, in: imageView, showLoading: true)
            }
        }
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = virtualCard.dataValidadeFmt {
            label.text = "Validade: \(value)"
            
            label.layer.shadowOffset = CGSize(width: 0, height: 0)
            label.layer.shadowOpacity = 1
            label.layer.shadowRadius = 6
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = virtualCard.apelidoVirtual {
            label.text = "\(value)"
            
            label.layer.shadowOffset = CGSize(width: 0, height: 0)
            label.layer.shadowOpacity = 1
            label.layer.shadowRadius = 6
        }
        
        if let label = cell.viewWithTag(4) as? UILabel, let value = virtualCard.credencialMascarada {
            label.text = "\(value)"
            
            label.layer.shadowOffset = CGSize(width: 0, height: 0)
            label.layer.shadowOpacity = 1
            label.layer.shadowRadius = 6
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResquestNewVirtualCardSegue" {
            let viewController = segue.destination as! ResquestNewVirtualCardView
            viewController.virtualCard = virtualCard
        } else if segue.identifier == "MessageErrorSegue" {
            messageErrorView = segue.destination as! MessageErrorView
        }
    }
}
