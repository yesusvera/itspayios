//
//  CardsTabBarController.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/15/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import Instructions

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
    // MARK: - Public properties
    var coachMarksController: CoachMarksController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tabBar.tintColor = UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        
        configureNavigationBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateCartBadges), name: NSNotification.Name.init("updateCartBadges"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.selectTabBarIndexObsever), name: NSNotification.Name.init("selectTabBarIndexObsever"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.expiredSessionObserver), name: NSNotification.Name.init("expiredSessionObserver"), object: nil)
        
        self.coachMarksController = CoachMarksController()
        
        self.coachMarksController?.overlay.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
        
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle("Skip", for: .normal)
        skipView.setTitleColor(UIColor.white, for: .normal)
        skipView.setBackgroundImage(nil, for: .normal)
        skipView.setBackgroundImage(nil, for: .highlighted)
        skipView.layer.cornerRadius = 0
        skipView.backgroundColor = UIColor.darkGray
        
        self.coachMarksController?.dataSource = self
        self.coachMarksController?.overlay.allowTap = true
        
        if !LoginController.sharedInstance.pemissionMarketPlace! {
            
            let loja = 1 //0 to 5
            viewControllers?.remove(at: loja)
            let meusPedidos = 1 //0 to 5
            viewControllers?.remove(at: meusPedidos)
            let carrinho = 1 //0 to 5
            viewControllers?.remove(at: carrinho)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isTutorialValid: Bool = (UserDefaults.standard.object(forKey: "isTutorialValid") != nil)
        
        if(!isTutorialValid){
            startInstructions()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.coachMarksController?.stop(immediately: true)
    }
    
    func startInstructions() {
        self.coachMarksController?.startOn(self.viewControllers![0])
        
        UserDefaults.standard.set(true, forKey: "isTutorialValid")
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
        
        
        AlertComponent.showAlert(title: "", message: "A Sessão expirou.", actions: [login], viewController: self)
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


// MARK: - Protocol Conformance | CoachMarksControllerDataSource
extension CardsTabBarController: CoachMarksControllerDataSource {
    
       public func numberOfCoachMarks(for coachMarksController: Instructions.CoachMarksController) -> Int{
        return 1
    }
    
        public func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkAt index: Int) -> Instructions.CoachMark{
        
            
        _ = { (frame: CGRect) -> UIBezierPath in
            return UIBezierPath(rect: frame)
        }
        
        var coachMark : CoachMark
    
        
        let view = self.tabBar.items![1].value(forKey: "view")
        
        coachMark = coachMarksController.helper.makeCoachMark(for: view as! UIView?)
        
        coachMark.arrowOrientation = CoachMarkArrowOrientation.bottom
        
        coachMark.gapBetweenCoachMarkAndCutoutPath = 6.0
        
        return coachMark
    }
    
        func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: Instructions.CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?){
        
        let coachMarkBodyView = CustomCoachMarkBodyView()
        var coachMarkArrowView: CustomCoachMarkArrowView? = nil
        
        var width: CGFloat = 0.0

            coachMarkBodyView.hintLabel.text = "Conheça nossa loja virtual temos varias ofertas."
        coachMarkBodyView.nextButton.setTitle("teste proximo", for: UIControlState())
        
         let view = self.tabBar.items![1].value(forKey: "view") as! UIView
        
         width = view.bounds.width
        if let arrowOrientation = coachMark.arrowOrientation {
            coachMarkArrowView = CustomCoachMarkArrowView(orientation: arrowOrientation)
            
            let oneThirdOfWidth = coachMarksController.overlay.frame.size.width / 3
            let adjustedWidth = width >= oneThirdOfWidth ? width - 2 * coachMark.horizontalMargin : width
            
            coachMarkArrowView!.plate.addConstraint(NSLayoutConstraint(item: coachMarkArrowView!.plate, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: adjustedWidth))
        }
        
        return (bodyView: coachMarkBodyView as CoachMarkBodyView, arrowView: coachMarkArrowView)
    }
    
        func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, constraintsForSkipView skipView: UIView, inParent parentView: UIView) -> [NSLayoutConstraint]?{
        var constraints: [NSLayoutConstraint] = []
        var topMargin: CGFloat = 0.0
        
        if !UIApplication.shared.isStatusBarHidden {
            topMargin = UIApplication.shared.statusBarFrame.size.height
        }
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[skipView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["skipView": skipView]))
        
        if UIApplication.shared.isStatusBarHidden {
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[skipView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["skipView": skipView]))
        } else {
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-topMargin-[skipView(==44)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["topMargin": topMargin],
                                                                          views: ["skipView": skipView]))
        }
        
        return constraints

    }
}
