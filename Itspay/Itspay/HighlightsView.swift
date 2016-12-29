//
//  HighlightsView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/20/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class HighlightsView: UICollectionViewController {
    var arrayProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: SCREEN_WIDTH/2, height: 220)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView!.collectionViewLayout = layout
        
        searchHighlightedProducts()
    }
    
    func searchHighlightedProducts() {
//        if Repository.isMockOn() {
        if let array = Repository.getPListValue(.mocks, key: "arrayProducts").jsonObject() as? [Any] {
            for object in array {
                arrayProducts.append(Product(object: object))
            }
            
            self.collectionView?.reloadData()
        }
//        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayProducts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightsCellIdentifier", for: indexPath)
        
        let product = arrayProducts[indexPath.row]
        
        if let label = cell.viewWithTag(1) as? UILabel, let value = product.titulo {
            label.text = "\(value)"
        }

        if let imageView = cell.viewWithTag(2) as? UIImageView, let value = product.urlImagem {
            imageView.image = UIImage(named: value)
        }
        
        if let label = cell.viewWithTag(3) as? UILabel, let value = product.precoAntigo {
            label.text = "\(value)"
        }
        
        if let label = cell.viewWithTag(4) as? UILabel, let value = product.precoAtual {
            label.text = "\(value)"
        }

        if let label = cell.viewWithTag(5) as? UILabel, let value = product.precoParcelado {
            label.text = "\(value)"
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
