//
//  SideMenuObject.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/19/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class SideMenuObject {
    var imagePath : String?
    var title : String?
    
    init(title : String, imagePath : String) {
        self.title = title
        self.imagePath = imagePath
    }
}
