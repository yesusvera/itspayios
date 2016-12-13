//
//  Extensions.swift
//  HOMEBROKER
//
//  Created by Arthur Augusto Sousa Marques on 8/2/16.
//  Copyright © 2016 bb. All rights reserved.
//

import UIKit

extension UIViewController {
    fileprivate struct AssociatedKeys {
        static var pageIndex = 0
    }
    
    var pageIndex: Int? {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.pageIndex) as? Int else {
                return nil
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.pageIndex, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
