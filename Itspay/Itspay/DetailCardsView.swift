//
//  DetailCards.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/17/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import SideMenu

class DetailCardsView: UITableViewController {
    @IBOutlet var segmentedControlValue: UISegmentedControl!
    @IBOutlet var buttonMenuValue: UIButton!

    @IBOutlet weak var imageViewCard: UIImageView!
    
    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCardNumber: UILabel!
    
    var virtualCard : Credenciais!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cartão"
        
        let viewMenu = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        buttonMenuValue.frame = CGRect(x: 8, y: 0, width: buttonMenuValue.frame.width, height: buttonMenuValue.frame.height)
        viewMenu.addSubview(buttonMenuValue)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: viewMenu)
        
        configMenuNavigationController()
        updateViewInfo()
    }
    
    func configMenuNavigationController() {
        let sideMenuTableViewController = instantiateFrom("General", identifier: "SideMenuTableViewController") as! SideMenuTableViewController
        
        let sideNavigationController = UISideMenuNavigationController(rootViewController: sideMenuTableViewController)
        
        sideNavigationController.leftSide = false
        
        SideMenuManager.menuRightNavigationController = sideNavigationController
        
        var arraySideMenuObjects = [SideMenuObject]()
        
        arraySideMenuObjects.append(SideMenuObject(title: "Transferir", imagePath: ""))
        arraySideMenuObjects.append(SideMenuObject(title: "Inserir Carga", imagePath: ""))
        
        sideMenuTableViewController.arraySideMenuObjects = arraySideMenuObjects
        sideMenuTableViewController.tableView.reloadData()
        
        SideMenuManager.menuAddPanGestureToPresent(toView: sideNavigationController.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: sideNavigationController.view)
    }
    
    func updateViewInfo() {
        if let object = virtualCard.urlImagemProduto {
            if Repository.isMockOn() {
                imageViewCard.image = UIImage(named: object)
            }
        }
        
        if let object = virtualCard.saldo {
            labelBalance.text = "\(object)"
        }
        
        if let object = virtualCard.nomeImpresso {
            labelName.text = "\(object)"
        }
        
        if let object = virtualCard.credencialUltimosDigitos {
            labelCardNumber.text = "**** **** **** \(object)"
        }
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func buttonMenuAction(_ sender: UIButton) {
        present(SideMenuManager.menuRightNavigationController!, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        
        segmentedControlValue.frame = CGRect(x: 8, y: 0, width: header.frame.width-16, height: segmentedControlValue.frame.height)
        header.addSubview(segmentedControlValue)
        
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCardsCellIdentifier", for: indexPath)

        if let _ = cell.viewWithTag(1) as? UILabel {
            
        }
        
        if let _ = cell.viewWithTag(2) as? UILabel {
            
        }

        return cell
    }
}
