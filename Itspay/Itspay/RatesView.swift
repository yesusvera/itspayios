//
//  RatesView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/22/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class RatesView: UITableViewController {
    @IBOutlet weak var errorView: ErrorView!
    
    var arrayTariffs = [Tariff]()
    
    var virtualCard : Credenciais!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorView.instantiate(in: self.view, addToView: true)
        
        self.title = "Tarifas"
        
        searchTariffs()
        
        self.refreshControl = UIRefreshControl(frame: CGRect.zero)
        self.refreshControl?.addTarget(self, action: #selector(self.searchTariffs), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl!)
    }

    func searchTariffs() {
        let url = CardsController.createSearchTariffURLPath(virtualCard)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            self.refreshControl?.endRefreshing()
            
            LoadingProgress.stopAnimating()
            
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? NSDictionary {
                    if let array = value["perfilsTarifarios"] as? [Any] {
                        self.arrayTariffs = [Tariff]()
                        
                        for object in array {
                            let tariff = Tariff(object: object)
                            
                            self.arrayTariffs.append(tariff)
                        }
                        
                        if self.arrayTariffs.count == 0 {
                            self.errorView.msgError = "O cartão não possui tarifas."
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTariffs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatesCellIdentifier", for: indexPath)

        let tariff = arrayTariffs[indexPath.row]
        
        if let label = cell.viewWithTag(1) as? UILabel, let value = tariff.descTransacaoEstendida {
            label.text = "\(value)"
        }
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = tariff.valorTarifa {
            label.text = "\(value)".formatToCurrencyReal()
        }
        
        return cell
    }
}
