//
//  CardsTabBarController.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/15/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

enum TabBarItemType : Int {
    case cards = 1
    case highlights = 2
    case cart = 3
    case settings = 4
}

class CardsTabBarController: UITabBarController {
    @IBOutlet var buttonSair: UIButton!
    
    var barButtonSair = UIBarButtonItem()
    
    var titleBar = "Meus Cartões"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        
        configureNavigationBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateCartBadges), name: NSNotification.Name.init("updateCartBadges"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.selectTabBarIndexObsever), name: NSNotification.Name.init("selectTabBarIndexObsever"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.expiredSessionObserver), name: NSNotification.Name.init("expiredSessionObserver"), object: nil)
    }
    
    func updateCartBadges() {
        if let items = self.tabBar.items {
            let tabBarItem = items[3]
            
            if MarketPlaceController.sharedInstance.cartProductsReferences.count > 0 {
                tabBarItem.badgeValue = "\(MarketPlaceController.sharedInstance.cartProductsReferences.count)"
            } else {
                tabBarItem.badgeValue = nil
            }
        }
    }
    
    func selectTabBarIndexObsever(notification : Notification) {
        if let index = notification.object as? Int {
            self.selectedIndex = index
        }
    }
    
    func expiredSessionObserver() {
        let login = UIAlertAction(title: "Fazer Login", style: .default) { (completion) in
            LoginController.logout(self)
        }
        
        let ok = UIAlertAction(title: "Ok", style: .default) { (completion) in
        }
        
        AlertComponent.showAlert(title: "", message: "A Sessão expirou.", actions: [login, ok], viewController: self)
    }
    
    func configureNavigationBar() {
        self.title = titleBar
        
        barButtonSair = UIBarButtonItem(customView: buttonSair)
        
        self.navigationItem.rightBarButtonItem = barButtonSair
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == TabBarItemType.cards.rawValue {
            titleBar = "Meus Cartões"
        } else if item.tag == TabBarItemType.highlights.rawValue {
            titleBar = "Loja"
        } else if item.tag == TabBarItemType.cart.rawValue {
            titleBar = "Carrinho"
        } else if item.tag == TabBarItemType.settings.rawValue {
            titleBar = "Ajustes"
        }
        
        self.title = titleBar
    }
    
    @IBAction func buttonSairAction(_ sender: UIButton) {
        let yes = UIAlertAction(title: "Sim", style: .default) { (completion) in
            LoginController.logout(self)
        }
        let no = UIAlertAction(title: "Não", style: .default) { (completion) in
        }

        AlertComponent.showAlert(title: "Atenção", message: "Deseja realmente sair?", actions: [yes, no], viewController: self)
    }
}
