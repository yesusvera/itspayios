//
//  RequestVirtualCardsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/26/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class RequestVirtualCardsView: UITableViewController {
    @IBOutlet weak var errorView: ErrorView!
    
    var arrayVirtualCards = [Credenciais]()
    
    var virtualCard : Credenciais!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorView.instantiate(in: self.view, addToView: false)
        
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
                            self.errorView.msgError = "Você ainda não possui cartões. Quando solicitá-los, eles aparecerão aqui"
                        } else {
                            self.errorView.msgError = ""
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
        return 160
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
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = virtualCard.apelidoVirtual {
            label.text = "\(value)"
            
            label.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = virtualCard.credencialVirtual {
            label.text = value.cardNumberFormatted()
            
            label.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        }
        
        if let label = cell.viewWithTag(4) as? UILabel, let value = virtualCard.dataValidadeFmt {
            label.text = "\(value)"
            
            label.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        }
        
        if let label = cell.viewWithTag(5) as? UILabel, let value = virtualCard.codigoSeguranca {
            label.text = "\(value)"
            
            label.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        }
        
        if let label = cell.viewWithTag(6) as? UILabel, let value = virtualCard.nomeImpresso {
            label.text = "\(value)"
            
            label.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResquestNewVirtualCardSegue" {
            let viewController = segue.destination as! ResquestNewVirtualCardView
            viewController.requestCardViewController = self
            viewController.virtualCard = virtualCard
        }
    }
}
