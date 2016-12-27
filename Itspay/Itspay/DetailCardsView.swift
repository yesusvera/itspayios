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
    
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var viewFooter: UIView!
    
    @IBOutlet weak var labelCurrentBalance: UILabel!
    @IBOutlet weak var labelTransactionDate: UILabel!
    
    var messageErrorView : MessageErrorView!
    
    var virtualCard : Credenciais!
    
    var arrayVirtualCardStatement = [VirtualCardStatement]()
    
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
        
        self.refreshControl = UIRefreshControl(frame: CGRect.zero)
        
        self.refreshControl?.addTarget(self, action: #selector(self.getVirtualCardsStatement), for: .valueChanged)
        
        self.tableView.addSubview(self.refreshControl!)
    }
    
    func updateViewInfo() {
        CardsController.openPlastics(virtualCard, in: imageViewCard, showLoading: false)
        
        if let object = virtualCard.saldo {
            labelBalance.text = "\(object)".formatToCurrencyReal()
            labelBalance.layer.shadowOffset = CGSize(width: 0, height: 0)
            labelBalance.layer.shadowOpacity = 1
            labelBalance.layer.shadowRadius = 6

            labelCurrentBalance.text = "\(object)".formatToCurrencyReal()
        }
        
        if let object = virtualCard.dataValidadeFmt {
            labelTransactionDate.text = "\(object)"
        }
        
        if let object = virtualCard.nomeImpresso {
            labelName.text = "\(object)"
            labelName.layer.shadowOffset = CGSize(width: 0, height: 0)
            labelName.layer.shadowOpacity = 1
            labelName.layer.shadowRadius = 6
        }
        
        if let object = virtualCard.credencialMascarada {
            labelCardNumber.text = "\(object)"
            labelCardNumber.layer.shadowOffset = CGSize(width: 0, height: 0)
            labelCardNumber.layer.shadowOpacity = 1
            labelCardNumber.layer.shadowRadius = 6
        }
        
        if let object = virtualCard.nomeProduto {
            self.title = object
        }
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
        
        let url = CardsController.createVirtualCardStatementURLPath(virtualCard, dataInicial: Date().addDays(daysAgo), dataFinal: Date())
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            self.refreshControl?.endRefreshing()
            
            LoadingProgress.stopAnimating()
            
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? [Any] {
                    self.arrayVirtualCardStatement = [VirtualCardStatement]()
                    
                    for object in value {
                        let virtualCardStatement = VirtualCardStatement(object: object)
                        
                        self.arrayVirtualCardStatement.append(virtualCardStatement)
                    }
                    
                    if self.arrayVirtualCardStatement.count == 0 {
                        self.messageErrorView.updateView("Sem movimentação nesse período")
                    } else {
                        self.messageErrorView.updateView("")
                    }
                    
                    self.tableView.reloadData()
                }
            }
        })
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
                LoginController.logout()
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        getVirtualCardsStatement()
    }
    
    @IBAction func buttonMenuAction(_ sender: UIButton) {
        present(SideMenuManager.menuRightNavigationController!, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayVirtualCardStatement.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        
        header.backgroundColor = UIColor.white
        
        segmentedControlValue.frame = CGRect(x: 8, y: 8, width: header.frame.width-16, height: segmentedControlValue.frame.height)
        
        header.addSubview(segmentedControlValue)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if arrayVirtualCardStatement.count > 0 {
            return viewFooter.frame.height
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if arrayVirtualCardStatement.count > 0 {
            viewFooter.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: viewFooter.frame.height)
            
            return viewFooter
        }
        
        return nil
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCardsCellIdentifier", for: indexPath)
        
        let virtualCardStatement = arrayVirtualCardStatement[indexPath.row]
        
        var isSignalPositive = true
        var color = UIColor.colorFrom(hex: COLOR_GREEN_HEX)
        
        if let value = virtualCardStatement.sinal {
            if value < 0 {
                isSignalPositive = false
            }
        }

        if !isSignalPositive {
            color = UIColor.colorFrom(hex: COLOR_RED_HEX)
        }
        
        if let label = cell.viewWithTag(1) as? UILabel, let value = virtualCardStatement.dataTransacaoFmt {
            label.text = "\(value)"
            label.adjustsFontSizeToFitWidth = true
        }
        
        if let label = cell.viewWithTag(2) as? UILabel, let value = virtualCardStatement.descLocal {
            label.text = "\(value)"
            label.adjustsFontSizeToFitWidth = true
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = virtualCardStatement.valorTransacao {
            label.text = "\(value)".formatToCurrencyReal()
            label.textColor = color
            label.adjustsFontSizeToFitWidth = true
        }
        
        if let label = cell.viewWithTag(4) as? UILabel, let value = virtualCardStatement.descSeguimento {
            label.text = "\(value)"
            label.adjustsFontSizeToFitWidth = true
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TransferSegue" {
            let viewController = segue.destination as! TransferMainView
            viewController.virtualCard = virtualCard
        } else if segue.identifier == "ChargeSegue" {
            let viewController = segue.destination as! ChargeView
            viewController.virtualCard = virtualCard
        } else if segue.identifier == "RequestCardSegue" {
            let viewController = segue.destination as! RequestVirtualCardsView
            viewController.virtualCard = virtualCard
        } else if segue.identifier == "RatesSegue" {
            let viewController = segue.destination as! RatesView
            viewController.virtualCard = virtualCard
        } else if segue.identifier == "SecuritySettingsSegue" {
            let viewController = segue.destination as! SecuritySettingsView
            viewController.virtualCard = virtualCard
        } else if segue.identifier == "MessageErrorSegue" {
            messageErrorView = segue.destination as! MessageErrorView
        }
    }
}
