//
//  CardsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/12/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class CardsView: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getVirtualCards()
    }
    
    func getVirtualCards() {
        var url = Repository.createServiceURLFromPListValue(.services, key: "virtualCards")
        url += "/"
        
        if let value = LoginController.sharedInstance.loginResponseObject.idLogin {
            url += "\(value)"
        }
        
        Connection.request(url, method: .post, parameters: nil, dataResponseJSON: { (dataResponse) in
            if validateDataResponse(dataResponse: dataResponse, viewController: self) {
                if let value = dataResponse.result.value {
                    LoginController.sharedInstance.loginResponseObject = LoginResponseObject(object: value)
                    
                    self.performSegue(withIdentifier: "CardsSegue", sender: self)
                }
            }
        })
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsCellIdentifier", for: indexPath)


        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}
