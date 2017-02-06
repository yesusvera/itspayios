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
    
    var referenceEditing : Referencias?
    
    var arrayAddresses = [Address]()
    
    var totalPrice = Double(0)
    
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
    
    static func createAddressesURLPath() -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "addresses")
        
        if let value = LoginController.sharedInstance.loginResponseObject.cpf {
            url += "/\(value)"
        }
        
        url += "/pessoa/\(TIPO_PESSOA)/processadora/\(ID_PROCESSADORA)/instituicao/\(ID_INSTITUICAO)/status/\(STATUS)/"
        
        return url
    }
    
    static func createShippingFormsURLPath(_ productPartner : ProductPartner, address : Address) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "shippingForms")
        
        if let value = productPartner.idParceiro {
            url += "/\(value)"
        }
        
        url += "/endereco"

        if let value = address.idEndereco {
            url += "/\(value)"
        }
        
        return url
    }

    static func createShippingCredencialURLPath(_ myRequest : MyRequest) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "shippingCredencial")
        
        if let value = myRequest.idCredencial {
            url += "/\(value)"
        }
        
        return url
    }

    static func createShippingAccountURLPath(_ myRequest : MyRequest) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "shippingAccount")
        
        if let value = myRequest.idConta {
            url += "/\(value)"
        }
        
        return url
    }
    
    static func createMyRequestsURLPath() -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "myRequests")
        
        if let value = LoginController.sharedInstance.loginResponseObject.cpf {
            url += "/\(value)"
        }
        
        url += "/processadora/\(ID_PROCESSADORA)/instituicao/\(ID_INSTITUICAO)"
        
        return url
    }
    
    static func createMyRequestDetailsURLPath(_ myRequest : MyRequest) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "myRequestDetails")
        
        if let value = myRequest.idPedido {
            url += "/\(value)"
        }
        
        return url
    }
    
    static func createInstallmentPaymentURLPath(_ productPartner : ProductPartner) -> String {
        var url = Repository.createServiceURLFromPListValue(.services, key: "installmentPayment")
        
        if let value = productPartner.idParceiro {
            url += "/\(value)"
        }
        
        url += "/valor/\(MarketPlaceController.sharedInstance.totalPrice)"
        
        return url
    }
    
    static func createMakeOrderURLPath() -> String {
        return Repository.createServiceURLFromPListValue(.services, key: "makeOrder")
    }
    
    static func createMakeOrderParameters(_ productPartner : ProductPartner, virtualCard : Credenciais, arrayItens : [Referencias], address : Address, shippingForm : ShippingForm?, installmentPayment : InstallmentPayment, password : String) -> [String:Any] {
        var dictionary = [String:Any]()
        
        if let value = virtualCard.idConta {
            dictionary["idConta"] = value
        }
        if let value = virtualCard.idCredencial {
            dictionary["idCredencial"] = value
        }
        if let value = address.idEndereco {
            dictionary["idEndereco"] = value
        }
        if let value = productPartner.idParceiro {
            dictionary["idParceiro"] = value
        }
        
        var itens = [[String:Any]]()
        
        for item in arrayItens {
            var object = [String:Any]()
            
            if let value = item.idProduto {
                object["idProduto"] = value
            }
            if let value = item.idReferenciaSKU {
                object["idReferenciaSKU"] = value
            }
            if let value = item.idSKU {
                object["idSKU"] = value
            }
            if let value = item.quantidade {
                object["quantidadeItem"] = value
            }
            
            itens.append(object)
        }
        
        dictionary["itens"] = itens
        
        if let value = installmentPayment.quantidadeParcelas {
            dictionary["quantidadeParcelas"] = value
        }
        
        if let shippingForm = shippingForm {
            if let value = shippingForm.titulo {
                var tipo = 1
                if !value.contains("Normal") {
                    tipo = 2
                }
                dictionary["tipoEntrega"] = tipo
            }
            if let value = shippingForm.valor {
                dictionary["valorFrete"] = value
            }
        } else {
            dictionary["tipoEntrega"] = 0
            dictionary["valorFrete"] = 0
        }
        
        dictionary["senhaCredencial"] = password
        
        dictionary["idInstituicao"] = ID_INSTITUICAO
        dictionary["idProcessadora"] = ID_PROCESSADORA
        
        return dictionary
    }
    
    static func getProductPartnerAddress(_ productPartner : ProductPartner) -> Address? {
        var address : Address?
        
        if let unidades = productPartner.unidades {
            if let first = unidades.first {
                address = Address(object: first.dictionaryRepresentation())
            }
        }
        
        return address
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
                
                if let data = ImageStorage.imageData(from: url) {
                    imageView.image = UIImage(data: data)
                    return
                }
                
//                imageView.setShowActivityIndicator(showLoading)
                imageView.sd_setShowActivityIndicatorView(showLoading)
//                imageView.setIndicatorStyle(.gray)
                imageView.sd_setIndicatorStyle(.gray)
                
                Connection.requestData(url, method: .get, parameters: nil, dataResponse: { (dataResponse) in
                    if let data = dataResponse {
                        if let dataImage = Data(base64Encoded: data.base64EncodedString()) {
                            if dataImage.base64EncodedString().characters.count > 0 {
                                ImageStorage.storeImage(data: dataImage, at: url)
                                
                                imageView.image = UIImage(data: dataImage)
                                
                                return
                            }
                        }
                    }
                    
                    ImageStorage.removeImage(at: url)
                })
            }
        }
    }
    
    static func getProductImage(_ image : Imagens, in imageView : UIImageView, showLoading : Bool) {
        imageView.image = UIImage(named: "image_placeholder")
        
        if let idImagem = image.idImagem {
            let url = MarketPlaceController.createProductImageURLPath("\(idImagem)")
            
            if let data = ImageStorage.imageData(from: url) {
                imageView.image = UIImage(data: data)
                return
            }
            
//            imageView.setShowActivityIndicator(showLoading)
            imageView.sd_setShowActivityIndicatorView(showLoading)
//            imageView.setIndicatorStyle(.gray)
            imageView.sd_setIndicatorStyle(.gray)
            Connection.requestData(url, method: .get, parameters: nil, dataResponse: { (dataResponse) in
                if let data = dataResponse {
                    if let dataImage = Data(base64Encoded: data.base64EncodedString()) {
                        if dataImage.base64EncodedString().characters.count > 0 {
                            ImageStorage.storeImage(data: dataImage, at: url)
                            
                            imageView.image = UIImage(data: dataImage)
                            
                            return
                        }
                    }
                }
                
                ImageStorage.removeImage(at: url)
            })
        }
    }
    
    static func getProduct(with idImage : Int, in imageView : UIImageView, showLoading : Bool) {
        imageView.image = UIImage(named: "image_placeholder")
        
        let url = MarketPlaceController.createProductImageURLPath("\(idImage)")
        
        if let data = ImageStorage.imageData(from: url) {
            imageView.image = UIImage(data: data)
            return
        }
        
        //            imageView.setShowActivityIndicator(showLoading)
        imageView.sd_setShowActivityIndicatorView(showLoading)
        //            imageView.setIndicatorStyle(.gray)
        imageView.sd_setIndicatorStyle(.gray)
        
        Connection.requestData(url, method: .get, parameters: nil, dataResponse: { (dataResponse) in
            if let data = dataResponse {
                if let dataImage = Data(base64Encoded: data.base64EncodedString()) {
                    if dataImage.base64EncodedString().characters.count > 0 {
                        ImageStorage.storeImage(data: dataImage, at: url)
                        
                        imageView.image = UIImage(data: dataImage)
                        
                        return
                    }
                }
            }
            
            ImageStorage.removeImage(at: url)
        })
    }
    
    static func addProductReferenceToCart(_ reference : Referencias) {
        if let referenceEditing = MarketPlaceController.sharedInstance.referenceEditing {
            if let index = MarketPlaceController.sharedInstance.cartProductsReferences.index(of: referenceEditing) {
                MarketPlaceController.sharedInstance.cartProductsReferences.remove(at: index)
                MarketPlaceController.sharedInstance.cartProductsReferences.insert(reference, at: index)
            } else {
                MarketPlaceController.sharedInstance.cartProductsReferences.append(reference)
            }
        } else {
            MarketPlaceController.sharedInstance.cartProductsReferences.append(reference)
        }
    }
    
    static func splitReferencesByPartners(_ references : [Referencias]) -> [[Referencias]] {
        var array = [[Referencias]]()

        var partners = [String]()
        for reference in references {
            if let productPartner = reference.productPartner, let value = productPartner.nomeParceiro {
                if !partners.contains(value) {
                    partners.append(value)
                }
            }
        }
        
        for partner in partners {
            var newArray = [Referencias]()
            for reference in references {
                if let productPartner = reference.productPartner, let value = productPartner.nomeParceiro {
                    if value == partner {
                        newArray.append(reference)
                    }
                }
            }
            array.append(newArray)
        }
        
        return array
    }
    
    static func configureProductPartner(_ productPartner : ProductPartner) {
        if let produtos = productPartner.produtos {
            for product in produtos {
                var arrayIdImagens = [Int]()
                if let imagens = product.imagens {
                    for imagem in imagens {
                        if let idImagem = imagem.idImagem {
                            arrayIdImagens.append(idImagem)
                        }
                    }
                }
                
                if let referencias = product.referencias {
                    var count = 0
                    for referencia in referencias {
                        if count < arrayIdImagens.count {
                            referencia.idImagem = arrayIdImagens[count]
                        }
                        referencia.product = product
                        referencia.productPartner = productPartner
                        
                        count += 1
                    }
                }
            }
        }
    }
    
    static func createAllTagsArray(from array : [ProductPartner]) -> [String] {
        var allTags = [String]()
        
        for productPartner in array {
            if let products = productPartner.produtos {
                for product in products {
                    if let value = product.tipoProduto {
//                        if allTags.contains(value){
//                        }else{
//                            allTags.append(value)
//                        }

                    }
                    
                    if let categories = product.categorias {
                        for category in categories {
                            if let value = category.descricao {
                                if allTags.contains(value){
                                }else{
                                    allTags.append(value)
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return allTags
    }
    
    static func filterProductPartner(_ array : [ProductPartner], with tags : [String]) -> [ProductPartner] {
        var arrayProductPartnerCopy = [ProductPartner]()
        
        for productPartner in array {
            let productPartnerCopy = ProductPartner(object: productPartner.dictionaryRepresentation())
            
            var arrayProducts = [Produtos]()
            
            if let products = productPartner.produtos {
                for product in products {
                    var found = false
                    if let value = product.tipoProduto {
                        for tag in tags {
                            if value.lowercased().contains(tag.lowercased()) {
                                arrayProducts.append(product)
                                found = true
                                
                                break
                            }
                        }
                    }
                    
                    if !found {
                        if let value = product.nomeProduto {
                            for tag in tags {
                                if value.lowercased().contains(tag.lowercased()) {
                                    arrayProducts.append(product)
                                    found = true
                                    
                                    break
                                }
                            }
                        }
                    }
                    
                    if !found {
                        if let categories = product.categorias {
                            for category in categories {
                                if let value = category.descricao {
                                    for tag in tags {
                                        if value.lowercased().contains(tag.lowercased()) {
                                            arrayProducts.append(product)
                                            
                                            break
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            productPartnerCopy.produtos = arrayProducts
            arrayProductPartnerCopy.append(productPartnerCopy)
        }
        
        return arrayProductPartnerCopy
    }
}
