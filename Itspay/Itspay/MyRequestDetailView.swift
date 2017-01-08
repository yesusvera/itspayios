//
//  MyRequestDetailView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/7/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class MyRequestDetailView: UITableViewController {
    @IBOutlet weak var labelProductPartnerName: UILabel!
    
    @IBOutlet weak var imageViewProduct: UIImageView!
    
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductAmount: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    
    @IBOutlet weak var labelShippingType: UILabel!
    @IBOutlet weak var labelShippingPrice: UILabel!
    @IBOutlet weak var labelShippingAddress: UILabel!
    
    @IBOutlet weak var labelUsername: UILabel!
    
    @IBOutlet weak var labelPaymentAmount: UILabel!
    @IBOutlet weak var labelPaymentPrice: UILabel!
    
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    var myRequest : MyRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Detalhes do Pedido"
        
        getMyRequestDetails()
        
        updateViewInfo()
    }
    
    func getMyRequestDetails() {
        let url = MarketPlaceController.createMyRequestDetailsURLPath(myRequest)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let value = dataResponse.result.value {
                    self.myRequest = MyRequest(object: value)
                    
                    self.updateViewInfo()
                }
            }
        })
    }
    
    func updateViewInfo() {
        if let value = myRequest.idParceiro {
            labelProductPartnerName.text = "\(value)"
        }
        
        imageViewProduct.image = UIImage(named: "")
        
        
        labelProductName.text = ""
        labelProductAmount.text = ""
        labelProductPrice.text = ""
        
        labelShippingType.text = ""
        labelShippingPrice.text = ""
        labelShippingAddress.text = ""
        labelUsername.text = ""
        labelPaymentAmount.text = ""
        labelPaymentPrice.text = ""
        labelTotalPrice.text = ""
    }
}
