//
//  DetailProductView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/31/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class DetailProductView: UITableViewController, iCarouselDataSource, iCarouselDelegate {
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var stepperAmount: UIStepper!

    @IBOutlet weak var carouselProducts: iCarousel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductDescription: UILabel!
    @IBOutlet weak var labelProductOldPrice: UILabel!
    @IBOutlet weak var labelProductPaymentInstallments: UILabel!
    @IBOutlet weak var labelProductCurrentPrice: UILabel!
    
    @IBOutlet weak var labelTotal: UILabel!

    @IBOutlet weak var labelRescue: UILabel!
    
    @IBOutlet weak var buttonAddCartValue: UIButton!
    
    @IBOutlet var viewHeader: UIView!
    @IBOutlet var viewFooter: UIView!
    
    var productPartner : ProductPartner!
    var product : Produtos!
    
    var price = Double(0) {
        didSet {
            updateTotal()
        }
    }
    
    var amount = 1 {
        didSet {
            labelAmount.text = "\(amount)"
        }
    }
    
    var total = Double(0) {
        didSet {
            labelTotal.text = "\(total)".formatToCurrencyReal()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewInfo()
        configureCarousel()
        
        if let array = product.imagens {
            pageControl.numberOfPages = array.count
        }
    }
    
    func updateViewInfo() {
        self.title = "Detalhes do Produto"
        
        if let value = product.nomeProduto {
            labelProductName.text = "\(value)"
        }
        
        if let value = product.descricao {
            labelProductDescription.text = "\(value)"
        }
        
        if let array = product.referencias {
            if let object = array.first {
                if let value = object.precoDe {
                    labelProductOldPrice.attributedText = NSAttributedString.strikedText("De \("\(value)".formatToCurrencyReal())", color: UIColor.lightGray)
                }
                
                if let value = object.precoPor {
                    price = Double(value)
                    
                    labelProductCurrentPrice.text = "\(value)".formatToCurrencyReal()
                }
                
                if let value = productPartner.quantMaxParcelaSemJuros {
                    labelProductPaymentInstallments.text = "em até \(value) vezes"
                }
            }
        }
    }
    
    func configureCarousel() {
        carouselProducts.bounceDistance = 0.2
        carouselProducts.decelerationRate = 1.0
    }
    
    @IBAction func buttonAddCartAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ProductReferencesSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return viewFooter
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        if let array = product.imagens {
            return array.count
        }
        
        return 0
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: -16, width: SCREEN_WIDTH, height: carouselProducts.frame.height))
        view.backgroundColor = UIColor.clear
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.height*0.7, height: view.frame.height*0.7))
        
        imageView.backgroundColor = UIColor.clear
        imageView.center = view.center
        imageView.contentMode = .scaleAspectFit
        
        let imagem = product.imagens![index]
        
        MarketPlaceController.getProductImage(imagem, in: imageView, showLoading: true)
        
        view.addSubview(imageView)
        
        return view
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        pageControl.currentPage = carousel.currentItemIndex
    }
    
    @IBAction func stepperAmountAction(_ sender: UIStepper) {
        amount = Int(sender.value)
        
        updateTotal()
    }
    
    func updateTotal() {
        total = Double(amount) * price
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductReferencesSegue" {
            let viewController = segue.destination as! ProductReferencesView
            viewController.product = product
            viewController.amount = amount
        }
    }
}
