//
//  MyRequestsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/6/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class MyRequestsView: UITableViewController {
    var arrayMyRequests = [MyRequest]()
    
    var selectedMyRequest : MyRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Meus Pedidos"
        
        getMyRequests()
        
        self.refreshControl = UIRefreshControl(frame: CGRect.zero)
        
        self.refreshControl?.addTarget(self, action: #selector(self.getMyRequests), for: .valueChanged)
        
        self.tableView.addSubview(self.refreshControl!)
    }
    
    func getMyRequests() {
        let url = MarketPlaceController.createMyRequestsURLPath()
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let array = dataResponse.result.value as? [Any] {
                    self.arrayMyRequests = [MyRequest]()
                    
                    for object in array {
                        let myRequest = MyRequest(object: object)
                        
                        self.arrayMyRequests.append(myRequest)
                    }
                    
                    self.tableView.reloadData()
                }
            }
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMyRequests.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRequestsCellIdentifier", for: indexPath)

        let myRequest = arrayMyRequests[indexPath.row]
        
        if let label = cell.viewWithTag(1) as? UILabel, let value = myRequest.idPedido {
            label.text = "Pedido Nº \(value)"
        }
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = myRequest.dataHoraPedidoStr {
            label.text = "\(value)"
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = myRequest.valorTotal {
            if value < 0 {
                label.textColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
            } else {
                label.textColor = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
            }
            
            label.text = "\(value)".formatToCurrencyReal()
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMyRequest = arrayMyRequests[indexPath.row]
        
        self.performSegue(withIdentifier: "MyRequestDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyRequestDetailSegue" {
            let viewController = segue.destination as! MyRequestDetailView
            viewController.myRequest = selectedMyRequest
        }
    }
}
