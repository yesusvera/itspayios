//
//  SideMenuTableViewController.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/19/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    var arraySideMenuObjects = [SideMenuObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySideMenuObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewControllerCellIdentifier", for: indexPath)

        let sideMenu = arraySideMenuObjects[indexPath.row]
        
        if let label = cell.viewWithTag(1) as? UILabel, let object = sideMenu.title {
            label.text = object
        }
        
        if let imageView = cell.viewWithTag(2) as? UIImageView, let object = sideMenu.imagePath {
            imageView.image = UIImage(named: object)
        }
        
        return cell
    }
}
