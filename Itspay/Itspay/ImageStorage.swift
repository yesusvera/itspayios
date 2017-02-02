//
//  ImageStorage.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 2/2/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ImageStorage {
    static func imageData(from path : String) -> Data? {
        if let data = UserDefaults.standard.object(forKey: path) as? Data {
            return data
        }
        return nil
    }
    
    static func storeImage(data : Data, at path : String) {
        UserDefaults.standard.set(data, forKey: path)
    }
    
    static func removeImage(at path : String) {
        UserDefaults.standard.removeObject(forKey: path)
    }
}
