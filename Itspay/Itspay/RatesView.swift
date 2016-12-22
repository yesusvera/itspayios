//
//  RatesView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/22/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class RatesView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Tarifas"
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatesCellIdentifier", for: indexPath)

        if let _ = cell.viewWithTag(1) as? UILabel {
            
        }
        
        if let _ = cell.viewWithTag(2) as? UILabel {
            
        }
        
        if indexPath.row == 0 {
            if let viewTop = cell.viewWithTag(3) {
                viewTop.isHidden = true
            }
        }
        
        if indexPath.row == 9 {
            if let viewBottom = cell.viewWithTag(5) {
                viewBottom.isHidden = true
            }
        }
        
        return cell
    }
}
