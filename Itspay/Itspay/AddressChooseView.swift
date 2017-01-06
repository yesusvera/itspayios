//
//  AddressChoseView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/6/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class AddressChooseView: UITableViewController {
    var selectedAddress : Address!
    var productPartner : ProductPartner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Endereços"
        
        getAddresses()
    }
    
    func getAddresses() {
        let url = MarketPlaceController.createAddressesURLPath()
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let array = dataResponse.result.value as? [Any] {
                    MarketPlaceController.sharedInstance.arrayAddresses = [Address]()
                    
                    for object in array {
                        let address = Address(object: object)
                        
                        MarketPlaceController.sharedInstance.arrayAddresses.append(address)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MarketPlaceController.sharedInstance.arrayAddresses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressChooseCellIdentifier", for: indexPath)
        
        let address = MarketPlaceController.sharedInstance.arrayAddresses[indexPath.row]
        
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text = address.fullDescription()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAddress = MarketPlaceController.sharedInstance.arrayAddresses[indexPath.row]
        
        self.performSegue(withIdentifier: "ShippingFormsChooseSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShippingFormsChooseSegue" {
            let viewController = segue.destination as! ShippingFormsChooseView
            viewController.address = selectedAddress
            viewController.productPartner = productPartner
        }
    }
}
