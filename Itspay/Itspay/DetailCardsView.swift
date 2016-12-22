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
    
    var virtualCardStatement : VirtualCardStatement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectSideMenuItemObserver(_:)), name: NSNotification.Name.init("didSelectSideMenuItemObserver"), object: nil)
        
        self.title = "Cartão"
        
        let viewMenu = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        buttonMenuValue.frame = CGRect(x: 8, y: 0, width: buttonMenuValue.frame.width, height: buttonMenuValue.frame.height)
        viewMenu.addSubview(buttonMenuValue)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: viewMenu)
        
        getDetailVirtualCards()
        getVirtualCardsStatement()
        configMenuNavigationController()
        updateViewInfo()
    }
    
    func didSelectSideMenuItemObserver(_ notification : Notification) {
        dismiss(animated: true, completion: nil)
        
        if let object = notification.object as? SideMenuObject {
            if object.menuType == .transfer {
                self.performSegue(withIdentifier: "TransferSegue", sender: self)
            } else if object.menuType == .charge {
                self.performSegue(withIdentifier: "ChargeSegue", sender: self)
            } else if object.menuType == .card {
                self.performSegue(withIdentifier: "RequestCardSegue", sender: self)
            } else if object.menuType == .security {
                self.performSegue(withIdentifier: "SecuritySettingsSegue", sender: self)
            } else if object.menuType == .rates {
                self.performSegue(withIdentifier: "RatesSegue", sender: self)
            } else if object.menuType == .logout {
                print("logout")
            }
        }
    }
    
    func getDetailVirtualCards() {
        let url = CardsController.createDetailVirtualCardsURLPath(virtualCard)
        
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value {
                    self.virtualCard = Credenciais(object: value)
                    
                    self.updateViewInfo()
                }
            }
        })
    }
    
    func getVirtualCardsStatement() {
        let daysAgo = (15 * (segmentedControlValue.selectedSegmentIndex+1)) * -1
        
        let url = CardsController.createVirtualCardStatementURLPath(virtualCard, dataInicial: Date(), dataFinal: Date().addDays(daysAgo))
        
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? NSDictionary {
                    self.virtualCardStatement = VirtualCardStatement(object: value)
                }
            }
        })
    }
    
    func configMenuNavigationController() {
        let sideMenuTableViewController = instantiateFrom("General", identifier: "SideMenuTableViewController") as! SideMenuTableViewController
        
        let sideNavigationController = UISideMenuNavigationController(rootViewController: sideMenuTableViewController)
        
        sideNavigationController.leftSide = false
        
        SideMenuManager.menuRightNavigationController = sideNavigationController
        
        var arraySideMenuObjects = [SideMenuObject]()
        
        if let idProduto = virtualCard.idProduto {
            if idProduto == 2 || idProduto == 3 {
                arraySideMenuObjects.append(SideMenuObject(title: "Ajustes de Segurança", imagePath: "lock", menuType: .security))
                arraySideMenuObjects.append(SideMenuObject(title: "Sair", imagePath: "logout", menuType: .logout))
            } else {
                arraySideMenuObjects.append(SideMenuObject(title: "Transferir", imagePath: "transfer", menuType: .transfer))
                arraySideMenuObjects.append(SideMenuObject(title: "Inserir Carga", imagePath: "charge", menuType: .charge))
                arraySideMenuObjects.append(SideMenuObject(title: "Cartões Virtuais", imagePath: "card", menuType: .card))
                arraySideMenuObjects.append(SideMenuObject(title: "Ajustes de Segurança", imagePath: "lock", menuType: .security))
                arraySideMenuObjects.append(SideMenuObject(title: "Tarifas", imagePath: "cash", menuType: .rates))
                arraySideMenuObjects.append(SideMenuObject(title: "Sair", imagePath: "logout", menuType: .logout))
            }
        }

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
            labelBalance.text = "\(object)".formatToCurrencyReal()
        }
        
        if let object = virtualCard.nomeImpresso {
            labelName.text = "\(object)"
        }
        
        if let object = virtualCard.credencialMascarada {
            labelCardNumber.text = "\(object)"
        }
        
        if let object = virtualCard.nomeProduto {
            self.title = object
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TransferSegue" {
            let viewController = segue.destination as! TransferMainView
            viewController.virtualCard = virtualCard
        }
    }
}
