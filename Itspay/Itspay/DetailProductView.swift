//
//  DetailProductView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/31/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class DetailProductView: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var stepperAmount: UIStepper!

    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    @IBAction func buttonAddCartAction(_ sender: UIButton) {
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let array = product.imagens {
            return array.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailProductCellIdentifier", for: indexPath)
        
        if let array = product.imagens {
            let imagem = array[indexPath.row]
            
            if let imageView = cell.viewWithTag(1) as? UIImageView {
                MarketPlaceController.getProductImage(imagem, in: imageView, showLoading: true)
            }
        }
        
        return cell
    }
    
    @IBAction func stepperAmountAction(_ sender: UIStepper) {
        amount = Int(sender.value)
        
        updateTotal()
    }
    
    func updateTotal() {
        total = Double(amount) * price
    }
}
