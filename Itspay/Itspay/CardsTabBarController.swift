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
        self.coachMarksController?.dataSource = self
        self.coachMarksController?.overlay.allowTap = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startInstructions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.coachMarksController?.stop(immediately: true)
    }
    
    func startInstructions() {
        self.coachMarksController?.startOn(self.viewControllers![0])
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


// MARK: - Protocol Conformance | CoachMarksControllerDataSource
extension CardsTabBarController: CoachMarksControllerDataSource {
    
    /// Asks for the number of coach marks to display.
    ///
    /// - Parameter coachMarksController: the coach mark controller requesting
    ///                                   the information.
    ///
    /// - Returns: the number of coach marks to display.
    public func numberOfCoachMarks(for coachMarksController: Instructions.CoachMarksController) -> Int{
        return 1
    }
    
    /// Asks for the metadata of the coach mark that will be displayed in the
    /// given nth place. All `CoachMark` metadata are optional or filled with
    /// sensible defaults. You are not forced to provide the `cutoutPath`.
    /// If you don't the coach mark will be dispayed at the bottom of the screen,
    /// without an arrow.
    ///
    /// - Parameter coachMarksController: the coach mark controller requesting
    ///                                   the information.
    /// - Parameter coachMarkViewsForIndex: the index referring to the nth place.
    ///
    /// - Returns: the coach mark metadata.
    public func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkAt index: Int) -> Instructions.CoachMark{
        // This will create cutout path matching perfectly the given view.
        // No padding!
        let flatCutoutPathMaker = { (frame: CGRect) -> UIBezierPath in
            return UIBezierPath(rect: frame)
        }
        
        var coachMark : CoachMark
    
        
        coachMark = coachMarksController.helper.makeCoachMark(for: self.tabBar)
        
//        var item: UITabBarItem = self.tabBar.items![0]
//        
//        coachMark = coachMarksController.helper.makeCoachMark(for: item.image) { (frame: CGRect) -> UIBezierPath in
//            // This will create a circular cutoutPath, perfect for the circular avatar!
//            return UIBezierPath(ovalIn: frame.insetBy(dx: -4, dy: -4))
//        }

        coachMark.arrowOrientation = CoachMarkArrowOrientation.top
        
        coachMark.gapBetweenCoachMarkAndCutoutPath = 6.0
        
        return coachMark

    }
    
    /// Asks for the views defining the coach mark that will be displayed in
    /// the given nth place. The arrow view is optional. However, if you provide
    /// one, you are responsible for supplying the proper arrow orientation.
    /// The expected orientation is available through
    /// `coachMark.arrowOrientation` and was computed beforehand.
    ///
    /// - Parameter coachMarksController: the coach mark controller requesting
    ///                                   the information.
    /// - Parameter coachMarkViewsForIndex: the index referring to the nth place.
    /// - Parameter coachMark: the coach mark meta data.
    ///
    /// - Returns: a tuple packaging the body component and the arrow component.
    func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: Instructions.CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?){
        
        let coachMarkBodyView = CustomCoachMarkBodyView()
        var coachMarkArrowView: CustomCoachMarkArrowView? = nil
        
        var width: CGFloat = 0.0
        
        switch(index) {
        case 0:
            coachMarkBodyView.hintLabel.text = "teste"
            coachMarkBodyView.nextButton.setTitle("teste proximo", for: UIControlState())
            
//            if let avatar = self.tabBar.itemWidth {
                width = self.tabBar.itemWidth
//            }
        default: break
        }
        
        // We create an arrow only if an orientation is provided (i. e., a cutoutPath is provided).
        // For that custom coachmark, we'll need to update a bit the arrow, so it'll look like
        // it fits the width of the view.
        if let arrowOrientation = coachMark.arrowOrientation {
            coachMarkArrowView = CustomCoachMarkArrowView(orientation: arrowOrientation)
            
            // If the view is larger than 1/3 of the overlay width, we'll shrink a bit the width
            // of the arrow.
            let oneThirdOfWidth = coachMarksController.overlay.frame.size.width / 3
            let adjustedWidth = width >= oneThirdOfWidth ? width - 2 * coachMark.horizontalMargin : width
            
            coachMarkArrowView!.plate.addConstraint(NSLayoutConstraint(item: coachMarkArrowView!.plate, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: adjustedWidth))
        }
        
        return (bodyView: coachMarkBodyView as! CoachMarkBodyView, arrowView: coachMarkArrowView)
    }
    
    /// Asks for autolayout constraints needed to position `skipView` in
    /// `coachMarksController.view`.
    ///
    /// - Parameter coachMarksController: the coach mark controller requesting
    ///                                   the information.
    /// - Parameter skipView: the view holding the skip button.
    /// - Parameter inParentView: the parent view (used to set contraints properly).
    ///
    /// - Returns: an array of NSLayoutConstraint.
    func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, constraintsForSkipView skipView: UIView, inParent parentView: UIView) -> [NSLayoutConstraint]?
    {
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
