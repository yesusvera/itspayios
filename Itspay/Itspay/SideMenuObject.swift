//
//  SideMenuObject.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/19/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

enum SideMenuType {
    case transfer
    case charge
    case card
    case security
    case rates
    case logout
}

class SideMenuObject {
    var imagePath : String?
    var title : String?
    var menuType = SideMenuType.transfer
    
    init(title : String, imagePath : String, menuType : SideMenuType) {
        self.title = title
        self.imagePath = imagePath
        self.menuType = menuType
    }
}
