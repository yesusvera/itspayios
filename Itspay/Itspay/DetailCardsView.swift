//
//  DetailCards.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/17/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import SideMenu
import VHBoomMenuButton

class DetailCardsView: UITableViewController, VHBoomDelegate {
    @IBOutlet var segmentedControlValue: UISegmentedControl!
    @IBOutlet var buttonMenuValue: UIButton!

    @IBOutlet weak var cardInfoView: CardInfoView!
    
    @IBOutlet var viewHeader: UIView!
    
    @IBOutlet weak var labelCurrentBalance: UILabel!
    @IBOutlet weak var labelTransactionDate: UILabel!
    
    @IBOutlet weak var errorView: ErrorView!
    
    var boomMenuButton = VHBoomMenuButton()
    
    var virtualCard : Credenciais!
    
    var arrayVirtualCardStatement = [VirtualCardStatement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.instantiate(in: self.view, addToView: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didSelectSideMenuItemObserver(_:)), name: NSNotification.Name.init("didSelectSideMenuItemObserver"), object: nil)
        
        self.title = "Cartão"
        
        configBoomMenuButton()
        
        configMenuNavigationController()
        updateViewInfo()
        
        self.refreshControl = UIRefreshControl(frame: CGRect.zero)
        
        self.refreshControl?.addTarget(self, action: #selector(self.getDetailVirtualCards), for: .valueChanged)
        
        self.tableView.addSubview(self.refreshControl!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDetailVirtualCards()
        
        configBoomMenuButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let window = appDelegate.window {
            if let subviews = window?.subviews {
                for subview in subviews {
                    if let boomView = subview as? VHBoomMenuButton {
                        boomView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    func configBoomMenuButton() {
        boomMenuButton = VHBoomMenuButton(frame: CGRect(x: SCREEN_WIDTH-50-16, y: SCREEN_HEIGHT-50-16, width: 50, height: 50))
        
        if let window = appDelegate.window {
            window?.addSubview(boomMenuButton)
        }
        
        boomMenuButton.boomEnum = .parabola_3
        boomMenuButton.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        boomMenuButton.buttonPressedColor = UIColor.colorFrom(hex: COLOR_NAVIGATION_BAR_HEX)
        boomMenuButton.boomDelegate = self
        boomMenuButton.dimColor = UIColor.black.withAlphaComponent(0.5)
        
        boomMenuButton.buttonEnum = .VHButtonTextInsideCircle
        boomMenuButton.boomButtonBuilders = NSMutableArray()
        
        if let idProduto = virtualCard.idProdutoPlataforma {
            if idProduto == 2 || idProduto == 3 {
                boomMenuButton.piecePlaceEnum = .DOT_2_1
                boomMenuButton.buttonPlaceEnum = .SC_2_1
                
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "lock"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Ajustes"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "logout"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Sair"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
            }else if idProduto == 4{
                
                boomMenuButton.piecePlaceEnum = .DOT_3_1
                boomMenuButton.buttonPlaceEnum = .SC_3_1
                
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "lock"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Ajustes"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "logout"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Sair"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                    
                    boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                        builder?.imageNormal = "change_key"
                        builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                        builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                        builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                        builder?.textNormalColor = UIColor.white
                        builder?.textPressedColor = UIColor.white
                        builder?.font = UIFont.boldSystemFont(ofSize: 11)
                        builder?.lines = 2
                        builder?.lineBreakMode = .byClipping
                        builder?.textContent = "Senha do Cartão"
                        builder?.rotateImage = true
                        builder?.rotateText = true
                        builder?.shadowOffset = CGSize(width: 5, height: 5)
                        builder?.shadowOpacity = 0
                        builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
            }else if idProduto == 4{
                
                boomMenuButton.piecePlaceEnum = .DOT_4_1
                boomMenuButton.buttonPlaceEnum = .SC_4_1
                
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "virtual_card"
                    builder?.imageFrame = CGRect(x: 15, y: 20, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "lock"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Ajustes"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "logout"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Sair"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "change_key"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Senha do Cartão"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })

            }else {
                boomMenuButton.piecePlaceEnum = .DOT_7_1
                boomMenuButton.buttonPlaceEnum = .SC_7_1
                
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "transfer"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Transferir"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "charge"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Carga"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "virtual_card"
                    builder?.imageFrame = CGRect(x: 15, y: 20, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "cash"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Tarifas"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "lock"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Ajustes"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "logout"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Sair"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
                })
                
                
                boomMenuButton.addText(insideCircleButtonBuilderBlock: { (builder) in
                    builder?.imageNormal = "change_key"
                    builder?.imageFrame = CGRect(x: 15, y: 8, width: self.boomMenuButton.frame.width, height: self.boomMenuButton.frame.width)
                    builder?.buttonNormalColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
                    builder?.buttonPressedColor = UIColor.colorFrom(hex: COLOR_LIGHT_GRAY_HEX)
                    builder?.textNormalColor = UIColor.white
                    builder?.textPressedColor = UIColor.white
                    builder?.font = UIFont.boldSystemFont(ofSize: 11)
                    builder?.lines = 2
                    builder?.lineBreakMode = .byClipping
                    builder?.textContent = "Senha do Cartão"
                    builder?.rotateImage = true
                    builder?.rotateText = true
                    builder?.shadowOffset = CGSize(width: 5, height: 5)
                    builder?.shadowOpacity = 0
                    builder?.shadowColor = UIColor.colorFrom(hex: COLOR_RED_HEX)})
            }
        }
    }
    
    func onBoomClicked(_ index: Int32) {
        if let idProduto = virtualCard.idProdutoPlataforma {
            if idProduto == 2 || idProduto == 3 {
                if index.hashValue == 0 {
                    self.performSegue(withIdentifier: "SecuritySettingsSegue", sender: self)
                } else if index.hashValue == 1 {
                    LoginController.logout(self)
                }else{
                    customAlertPassword()
                }
            }  else if idProduto == 4 {
                
                if index.hashValue == 0 {
                    self.performSegue(withIdentifier: "RequestCardSegue", sender: self)
                } else if index.hashValue == 1{
                    self.performSegue(withIdentifier: "SecuritySettingsSegue", sender: self)
                } else if index.hashValue == 2 {
//                    LoginController.logout(self)
                    buttonComunicateAction()
                }else{
                    customAlertPassword()
                }
                
            }else {
                if index.hashValue == SideMenuType.transfer.rawValue {
                    self.performSegue(withIdentifier: "TransferSegue", sender: self)
                } else if index.hashValue == SideMenuType.charge.rawValue {
                    self.performSegue(withIdentifier: "ChargeSegue", sender: self)
                } else if index.hashValue == SideMenuType.card.rawValue {
                    self.performSegue(withIdentifier: "RequestCardSegue", sender: self)
                } else if index.hashValue == SideMenuType.security.rawValue {
                    self.performSegue(withIdentifier: "SecuritySettingsSegue", sender: self)
                } else if index.hashValue == SideMenuType.rates.rawValue {
                    self.performSegue(withIdentifier: "RatesSegue", sender: self)
                } else if index.hashValue == SideMenuType.logout.rawValue {
//                    LoginController.logout(self)
                    buttonComunicateAction()
                }else{
                    customAlertPassword()
                }
            }
        }
    }
    
    func onBoomWillShow() {
        
    }
    
    func onBoomWillHide() {
        
    }
    
    func updateViewInfo() {
        cardInfoView.updateView(with: virtualCard)
    }
    
    func configMenuNavigationController() {
        let sideMenuTableViewController = instantiateFrom("General", identifier: "SideMenuTableViewController") as! SideMenuTableViewController
        
        let sideNavigationController = UISideMenuNavigationController(rootViewController: sideMenuTableViewController)
        
        sideNavigationController.leftSide = false
        
        SideMenuManager.menuRightNavigationController = sideNavigationController
        
        var arraySideMenuObjects = [SideMenuObject]()
        
        if let idProduto = virtualCard.idProdutoPlataforma {
            if idProduto == 2 || idProduto == 3 {
                arraySideMenuObjects.append(SideMenuObject(title: "Ajustes de Segurança", imagePath: "lock", menuType: .security))
                arraySideMenuObjects.append(SideMenuObject(title: "Sair", imagePath: "logout", menuType: .logout))
                arraySideMenuObjects.append(SideMenuObject(title: "Nova Senha",imagePath: "card",menuType: .newPassword))
            }else if idProduto == 4 {
                arraySideMenuObjects.append(SideMenuObject(title: "Cartões Virtuais", imagePath: "card", menuType: .card))
                arraySideMenuObjects.append(SideMenuObject(title: "Ajustes de Segurança", imagePath: "lock", menuType: .security))
                arraySideMenuObjects.append(SideMenuObject(title: "Sair", imagePath: "logout", menuType: .logout))
                arraySideMenuObjects.append(SideMenuObject(title: "Nova Senha",imagePath: "card",menuType: .newPassword))
            }else {
                arraySideMenuObjects.append(SideMenuObject(title: "Transferir", imagePath: "transfer", menuType: .transfer))
                arraySideMenuObjects.append(SideMenuObject(title: "Inserir Carga", imagePath: "charge", menuType: .charge))
                arraySideMenuObjects.append(SideMenuObject(title: "Cartões Virtuais", imagePath: "card", menuType: .card))
                arraySideMenuObjects.append(SideMenuObject(title: "Ajustes de Segurança", imagePath: "lock", menuType: .security))
                arraySideMenuObjects.append(SideMenuObject(title: "Tarifas", imagePath: "cash", menuType: .rates))
                arraySideMenuObjects.append(SideMenuObject(title: "Sair", imagePath: "logout", menuType: .logout))
                arraySideMenuObjects.append(SideMenuObject(title: "Nova Senha",imagePath: "card",menuType: .newPassword))
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
                    
                    self.getVirtualCardsStatement()
                    
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
                        self.errorView.msgError = "Sem movimentação nesse período"
                    } else {
                        self.errorView.msgError = ""
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
//                LoginController.logout(self)
                buttonComunicateAction()
            }else if object.menuType == .newPassword {
               customAlertPassword()
            }
        }
    }
    
    func customAlertPassword(){
        
        let alert = UIAlertController(title: "Alterar Senha",
                                      message: "Para alterar senha do cartão digite a senha de acesso",
                                      preferredStyle: .alert)
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        // Add 1 textField and customize it
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Senha de acesso ao aplicativo"
            textField.clearButtonMode = .whileEditing
            textField.isSecureTextEntry = true
            textField.enablesReturnKeyAutomatically = true
        }
        
        // Submit button
        let submitAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let textField = alert.textFields![0]
            print(textField.text!)
            
            
            var password = ""
            if let value = UserDefaults.standard.object(forKey: "lastPasswordLogged") as? String {
                password = value
            }
            
            if textField.text == password {
                
                self.performSegue(withIdentifier: "changePasswordCard", sender: self)
            }else{
                AlertComponent.showSimpleAlert(title: "Alerta", message: "Senha Invalida", viewController: self)
            }
        })
        
        // Add action buttons and present the Alert
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    //Alert Logout
    func buttonComunicateAction() {
        let message = "Deseja realmente Sair?"
    
        let yesAction = UIAlertAction(title: "Sim", style: .default) { (action) in
        LoginController.logout(self)
        }
        
        let noAction = UIAlertAction(title: "Não", style: .default) { (action) in }
        
        AlertComponent.showAlert(title: "Atenção", message: message, actions: [yesAction, noAction], viewController: self)
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
        segmentedControlValue.tintColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        
        header.addSubview(segmentedControlValue)
        
        return header
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
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = virtualCardStatement.valorTransacao, let signal = virtualCardStatement.sinal {
            if signal >= 0 {
                label.text = "+\(value)".formatToCurrencyReal()
            } else {
                label.text = "-\(value)".formatToCurrencyReal()
            }
            
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
            viewController.cardViewController = self
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
        }else if segue.identifier == "changePasswordCard"{
            let viewController = segue.destination as! ChangePasswordCardView
            viewController.virtualCard = virtualCard
            
        }
    }
}
