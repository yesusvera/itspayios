//
//  CardInfoView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/16/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class CardInfoView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelCardName: UILabel!
    @IBOutlet weak var labelCardNumber: UILabel!
    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var labelOwnerName: UILabel!

    @IBOutlet weak var constraintWidth: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup(){
        let view = loadViewFromNib()
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CardInfoView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    override func draw(_ rect: CGRect) {
        contentView.frame = rect
        
        labelBalance.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        labelCardNumber.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        labelCardName.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
        labelOwnerName.addShadow(with: CGSize(width: 0, height: 0), opacity: 1, radius: 6)
    }
    
    func updateView(with virtualCard : Credenciais) {
        CardsController.openPlastics(virtualCard, in: imageView, showLoading: true)
        
        if let value = virtualCard.nomeProduto {
            labelCardName.text = "\(value)"
        }
        
        if let value = virtualCard.credencialMascarada {
            labelCardNumber.text = "\(value)"
        }
        
        if let value = virtualCard.saldo {
            labelBalance.text = "\(value)".formatToCurrencyReal()
        }
        
        if let value = virtualCard.nomeImpresso {
            labelOwnerName.text = "\(value)"
        }
    }
}
