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
    
    @IBOutlet weak var labelShippingType: UILabel!
    @IBOutlet weak var labelShippingPrice: UILabel!
    @IBOutlet weak var labelShippingAddress: UILabel!
    
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelUserCard: UILabel!
    
    @IBOutlet weak var labelPaymentAmount: UILabel!
    @IBOutlet weak var labelPaymentPrice: UILabel!
    
    @IBOutlet weak var labelTotalPrice: UILabel!
    
    @IBOutlet weak var labelStatusDescription: UILabel!
    
    var shippingItemView : ShippingItemView!
    
    var myRequest : MyRequest!
    
    var myRequestDetail : MyRequestDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Detalhes do Pedido"
        
        getMyRequestDetails()
    }
    
    func getMyRequestDetails() {
        let url = MarketPlaceController.createMyRequestDetailsURLPath(myRequest)
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil, dataResponseJSON: { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: true, viewController: self) {
                if let value = dataResponse.result.value {
                    self.myRequestDetail = MyRequestDetail(object: value)
                    
                    self.updateViewInfo()
                }
            }
        })
    }
    
    func updateViewInfo() {
        if let value = myRequestDetail.nomeParceiro {
            labelProductPartnerName.text = "\(value)"
        }
        if let value = myRequestDetail.descTipoEntrega {
            labelShippingType.text = "\(value)"
        }
        if let value = myRequestDetail.valorFrete {
            labelShippingPrice.text = "\(value)".formatToCurrencyReal()
        }
        if let value = myRequestDetail.enderecoCompleto {
            labelShippingAddress.text = "\(value)"
        }
        
        if let value = myRequestDetail.nomeImpresso {
            labelUsername.text = "\(value)"
        }
        if let value = myRequestDetail.ultimos4Digitos {
            labelUserCard.text = "\(value)"
        }
        
        if let value = myRequestDetail.quantidadeParcelas {
            labelPaymentAmount.text = "\(value)x"
        }
        if let value = myRequestDetail.valorParcela {
            labelPaymentPrice.text = "\(value)".formatToCurrencyReal()
        }
        if let value = myRequestDetail.valorTotal {
            labelTotalPrice.text = "\(value)".formatToCurrencyReal()
        }
        
        if let value = myRequestDetail.descStatus {
            labelStatusDescription.text = "\(value)"
        }
        
        if let value = myRequestDetail.itensPedido {
            shippingItemView.arrayShippingItens = value
            shippingItemView.tableView.reloadData()
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if myRequestDetail != nil {
                if let value = myRequestDetail.itensPedido {
                    return CGFloat(80 * value.count)
                }
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShippingItemSegue" {
            shippingItemView = segue.destination as! ShippingItemView
            shippingItemView.isBuying = false
        }
    }
}
