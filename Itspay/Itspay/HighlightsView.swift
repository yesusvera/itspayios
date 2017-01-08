//
//  HighlightsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/20/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit
import PARTagPicker

class HighlightsView: UICollectionViewController, PARTagPickerDelegate {
    @IBOutlet var viewHeader: UIView!
    
    @IBOutlet var errorView: ErrorView!
    
    var tagPicker = PARTagPickerViewController()
    
    var allTags = [String]()
    
    var arrayProductPartner = [ProductPartner]()
    var arrayProductPartnerFiltered = [ProductPartner]()

    var selectedProductPartner : ProductPartner!
    var selectedProduct : Produtos!
    
    var possuiMarketPlace = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorView.instantiate(in: self.view, addToView: true)
        
        if let value = LoginController.sharedInstance.loginResponseObject.possuiMarketPlace {
            possuiMarketPlace = value
        }
        
        if possuiMarketPlace {
            configureErrorMessageView("Nenhum produto encontrado.")
            
            configureTagPicker()
            configureCollectionViewLayout()
            
            searchHighlightedProducts()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !possuiMarketPlace {
            configureErrorMessageView("Você não possui acesso à loja.")
        }
    }
    
    func configureErrorMessageView(_ message : String) {
        errorView.msgError = message
    }
    
    func configureTagPicker() {
        tagPicker.view.backgroundColor = UIColor.colorFrom(hex: COLOR_NAVIGATION_BAR_HEX)
        tagPicker.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: COLLECTION_VIEW_HEIGHT)
        tagPicker.view.autoresizingMask = .flexibleWidth
        tagPicker.delegate = self
        tagPicker.visibilityState = .topAndBottom
        
        tagPicker.allowsNewTags = true
        
        tagPicker.placeholderText = "Adicione um item"
        
        tagPicker.font = UIFont.systemFont(ofSize: 14)
        
        useTagsCustomColors()
        
        self.addChildViewController(tagPicker)
    }
    
    func addTagPickerToView() {
        tagPicker.view.removeFromSuperview()
        
        allTags = MarketPlaceController.createAllTagsArray(from: arrayProductPartner)
        
        tagPicker.allTags = allTags
        
        tagPicker.reloadCollectionViews()
        
        self.view.addSubview(tagPicker.view)
    }
    
    func useTagsCustomColors() {
        let myColors = PARTagColorReference()
        
        myColors.chosenTagBorderColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
        myColors.chosenTagBackgroundColor = UIColor.colorFrom(hex: COLOR_RED_HEX)
        myColors.chosenTagTextColor = UIColor.white
        
        myColors.defaultTagBorderColor = UIColor.colorFrom(hex: COLOR_YELLOW_HEX)
        myColors.defaultTagBackgroundColor = UIColor.colorFrom(hex: COLOR_YELLOW_HEX)
        myColors.defaultTagTextColor = UIColor.white
        
        tagPicker.tagColorRef = myColors
    }
    
    func configureHeaderView() {
        viewHeader.frame = CGRect(x: 0, y: tagPicker.view.frame.maxY+50, width: SCREEN_WIDTH, height: viewHeader.frame.height)
        
        self.view.addSubview(viewHeader)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: COLLECTION_VIEW_HEIGHT+32, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: SCREEN_WIDTH/2, height: 220)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView!.collectionViewLayout = layout
    }
    
    func tagPicker(_ tagPicker: PARTagPickerViewController!, visibilityChangedTo state: PARTagPickerVisibilityState) {
        var newHeight = CGFloat(0)
        
        if state == .topAndBottom {
            newHeight = 2 * COLLECTION_VIEW_HEIGHT
        } else if state == .topOnly {
            newHeight = COLLECTION_VIEW_HEIGHT
        }
        
        var frame = self.tagPicker.view.frame
        
        frame.size.height = newHeight
        
        UIView.animate(withDuration: 0.5) {
            self.tagPicker.view.frame = frame
        }
    }
    
    func chosenTagsWereUpdated(inTagPicker tagPicker: PARTagPickerViewController!) {
        guard let chosenTags = tagPicker.chosenTags as? [String] else {
            return
        }
        
        if chosenTags.count == 0 {
            arrayProductPartnerFiltered = [ProductPartner]()
            arrayProductPartnerFiltered.append(contentsOf: arrayProductPartner)
        } else {
            let array = MarketPlaceController.filterProductPartner(arrayProductPartner, with : chosenTags)
            
            arrayProductPartnerFiltered = [ProductPartner]()
            arrayProductPartnerFiltered.append(contentsOf: array)
            
            updateErrorMessageView()
        }
        
        self.collectionView?.reloadData()
    }
    
    func updateErrorMessageView() {
        errorView.isHidden = arrayProductPartnerFiltered.count != 0
    }
    
    func searchHighlightedProducts() {
        let url = MarketPlaceController.createProductPartnerURLPath()
        
        LoadingProgress.startAnimatingInWindow()
        Connection.request(url, method: .get, parameters: nil) { (dataResponse) in
            LoadingProgress.stopAnimating()
            if validateDataResponse(dataResponse, showAlert: false, viewController: self) {
                if let value = dataResponse.result.value as? [Any] {
                    self.arrayProductPartner = [ProductPartner]()
                    
                    for object in value {
                        let productPartner = ProductPartner(object: object)
                        
                        MarketPlaceController.configureProductPartner(productPartner)
                        
                        self.arrayProductPartner.append(productPartner)
                    }
                    
                    self.arrayProductPartnerFiltered = [ProductPartner]()
                    self.arrayProductPartnerFiltered.append(contentsOf: self.arrayProductPartner)
                    
                    self.updateErrorMessageView()
                    
                    self.addTagPickerToView()
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayProductPartnerFiltered.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let productPartner = arrayProductPartnerFiltered[section]
        
        if let array = productPartner.produtos {
            return array.count
        }
        
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightsCellIdentifier", for: indexPath)
        
        let productPartner = arrayProductPartnerFiltered[indexPath.section]
        
        let arrayProducts = productPartner.produtos!
        
        let product = arrayProducts[indexPath.row]
        
        if let label = cell.viewWithTag(1) as? UILabel, let value = product.nomeProduto {
            label.text = "\(value)"
        }

        if let imageView = cell.viewWithTag(2) as? UIImageView {
            MarketPlaceController.getMainProductImage(product, in: imageView, showLoading: true)
        }
        
        if let array = product.referencias {
            if let object = array.first {
                if let label = cell.viewWithTag(3) as? UILabel, let value = object.precoDe {
                    label.attributedText = NSAttributedString.strikedText("\(value)".formatToCurrencyReal(), color: UIColor.lightGray)
                }
                
                if let label = cell.viewWithTag(4) as? UILabel, let value = object.precoPor {
                    label.text = "\(value)".formatToCurrencyReal()
                }
                
                if let label = cell.viewWithTag(5) as? UILabel, let value = productPartner.quantMaxParcelaSemJuros, let price = object.precoPor {
                    label.text = "\(value)x de \("\(price / Float(value))".formatToCurrencyReal())"
                }
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productPartner = arrayProductPartnerFiltered[indexPath.section]
        
        let arrayProducts = productPartner.produtos!
        
        selectedProductPartner = productPartner
        selectedProduct = arrayProducts[indexPath.row]
        
        self.performSegue(withIdentifier: "DetailProductSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailProductSegue" {
            let viewController = segue.destination as! DetailProductView
            viewController.productPartner = selectedProductPartner
            viewController.product = selectedProduct
        }
    }
}
