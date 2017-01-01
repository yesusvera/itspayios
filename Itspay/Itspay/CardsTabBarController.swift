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

        configureNavigationBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateCartBadges), name: NSNotification.Name.init("updateCartBadges"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.selectTabBarIndexObsever), name: NSNotification.Name.init("selectTabBarIndexObsever"), object: nil)
    }
    
    func updateCartBadges() {
        if let tabBarController = self.tabBarController {
            if let items = tabBarController.tabBar.items {
                let tabBarItem = items[2]
                
                if MarketPlaceController.sharedInstance.cartProductsReferences.count > 0 {
                    tabBarItem.badgeValue = "\(MarketPlaceController.sharedInstance.cartProductsReferences.count)"
                } else {
                    tabBarItem.badgeValue = ""
                }
            }
        }
    }
    
    func selectTabBarIndexObsever(notification : Notification) {
        if let index = notification.object as? Int {
            self.selectedIndex = index
        }
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
        LoginController.logout()
        
        self.dismiss(animated: true, completion: nil)
    }
}
