//
//  MarketPlaceController.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/29/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class MarketPlaceController {
    static let sharedInstance = MarketPlaceController()
    
    var cartProductsReferences = [Referencias]()
    
    static func createProductPartnerURLPath() -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "productPartner")
        
        url += "/\(ID_PROCESSADORA)/\(ID_INSTITUICAO)"
        
        return url
    }
    
    static func createProductImageURLPath(_ image : String) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "productImage")
        
        url += "/\(image)"
        
        return url
    }
    
    static func getMainProductImage(_ product : Produtos, in imageView : UIImageView, showLoading : Bool) {
        imageView.image = UIImage(named: "image_placeholder")
        
        if let array = product.imagens {
            var image : Imagens?
            
            for imagem in array {
                if let main = imagem.principal {
                    if main {
                        image = imagem
                    }
                }
            }
            
            if let image = image, let idImagem = image.idImagem {
                let url = MarketPlaceController.createProductImageURLPath("\(idImagem)")
                
                var superview = UIView()
                
                if showLoading {
                    if let view = imageView.superview {
                        superview = view
                    } else {
                        superview = imageView
                    }
                    
                    LoadingProgress.startAnimating(in: superview, isAlphaReduced: false)
                }
                
                Connection.requestData(url, method: .get, parameters: nil, dataResponse: { (dataResponse) in
                    if showLoading {
                        LoadingProgress.stopAnimating(in: superview)
                    }
                    
                    if let data = dataResponse {
                        if let dataImage = Data(base64Encoded: data.base64EncodedString()) {
                            imageView.image = UIImage(data: dataImage)
                        }
                    }
                })
            }
        }
    }
    
    static func getProductImage(_ image : Imagens, in imageView : UIImageView, showLoading : Bool) {
        imageView.image = UIImage(named: "image_placeholder")
        
        if let idImagem = image.idImagem {
            let url = MarketPlaceController.createProductImageURLPath("\(idImagem)")
            
            var superview = UIView()
            
            if showLoading {
                if let view = imageView.superview {
                    superview = view
                } else {
                    superview = imageView
                }
                
                LoadingProgress.startAnimating(in: superview, isAlphaReduced: false)
            }
            
            Connection.requestData(url, method: .get, parameters: nil, dataResponse: { (dataResponse) in
                if showLoading {
                    LoadingProgress.stopAnimating(in: superview)
                }
                
                if let data = dataResponse {
                    if let dataImage = Data(base64Encoded: data.base64EncodedString()) {
                        imageView.image = UIImage(data: dataImage)
                    }
                }
            })
        }
    }
    
    static func getProduct(with idImage : Int, in imageView : UIImageView, showLoading : Bool) {
        imageView.image = UIImage(named: "image_placeholder")
        
        let url = MarketPlaceController.createProductImageURLPath("\(idImage)")
        
        var superview = UIView()
        
        if showLoading {
            if let view = imageView.superview {
                superview = view
            } else {
                superview = imageView
            }
            
            LoadingProgress.startAnimating(in: superview, isAlphaReduced: false)
        }
        
        Connection.requestData(url, method: .get, parameters: nil, dataResponse: { (dataResponse) in
            if showLoading {
                LoadingProgress.stopAnimating(in: superview)
            }
            
            if let data = dataResponse {
                if let dataImage = Data(base64Encoded: data.base64EncodedString()) {
                    imageView.image = UIImage(data: dataImage)
                }
            }
        })
    }
    
    static func addProductReferenceToCart(_ reference : Referencias) {
        MarketPlaceController.sharedInstance.cartProductsReferences.append(reference)
    }
    
    static func splitReferencesByPartners(_ references : [Referencias]) -> [[Referencias]] {
        var array = [[Referencias]]()

        var partners = [String]()
        for reference in references {
            if let value = reference.nomeParceiro {
                if !partners.contains(value) {
                    partners.append(value)
                }
            }
        }
        
        for partner in partners {
            var newArray = [Referencias]()
            for reference in references {
                if let value = reference.nomeParceiro {
                    if value == partner {
                        newArray.append(reference)
                    }
                }
            }
            array.append(newArray)
        }
        
        return array
    }
}
