//
//  CustomToastNotification.swift
//  Itspay
//
//  Created by Junior Braga on 13/02/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class CustomToastNotification {
    
//    In View
    func showNotification(view : UIView, title : String , menssage : String , nameImage : String) {
        let color =  UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        let image = UIImage(named: "cart")
        let title = title
        let subtitle = menssage + "                               "
        let banner = Banner(title: title, subtitle: subtitle, image: image, backgroundColor: color)
        banner.springiness = BannerSpringiness.none
        banner.position = BannerPosition.top
        
        banner.didTapBlock = {
            
        }
        banner.show(view, duration: 3.0)
    }
    
    func showNotification(view : UIView, title : String , menssage : String , nameImage : UIImage) {
        let color =  UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        let image = nameImage
        let title = title
        let subtitle = menssage + "                               "
        let banner = Banner(title: title, subtitle: subtitle, image: image, backgroundColor: color)
        banner.springiness = BannerSpringiness.none
        banner.position = BannerPosition.top
       
        banner.didTapBlock = {
            
        }
        banner.show(view, duration: 3.0)
    }
    
    
    func showNotification(view : UIView) {
        let color =  UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        let image = UIImage(named: "cart")
        let title = "Loja"
        let subtitle = "Conheça nossa as ofertas em nosaa loja                   "
        let banner = Banner(title: title, subtitle: subtitle, image: image, backgroundColor: color)
        banner.springiness = BannerSpringiness.none
        banner.position = BannerPosition.top
        
        banner.didTapBlock = {

        }
        banner.show(view, duration: 3.0)
    }
    
    
    
//    Top View
    func showNotificationTop(title : String , menssage : String , nameImage : String) {
        let color =  UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        let image = UIImage(named: "cart")
        let title = title
        let subtitle = menssage + "                               "
        let banner = Banner(title: title, subtitle: subtitle, image: image, backgroundColor: color)
        banner.springiness = BannerSpringiness.none
        banner.position = BannerPosition.top
        
        banner.didTapBlock = {
            
        }
        banner.show(duration: 3.0)
    }
    
    func showNotificationTop(title : String , menssage : String , nameImage : UIImage) {
        let color =  UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        let image = nameImage
        let title = title
        let subtitle = menssage + "                               "
        let banner = Banner(title: title, subtitle: subtitle, image: image, backgroundColor: color)
        banner.springiness = BannerSpringiness.none
        banner.position = BannerPosition.top
        
        banner.didTapBlock = {
            
        }
        banner.show(duration: 3.0)
    }
    
    func showNotificationTop() {
        let color =  UIColor.colorFrom(hex: COLOR_BUTTON_PRINCIPAL_HEX)
        let image = UIImage(named: "cart")
        let title = "Loja"
        let subtitle = "Conheça nossa as ofertas em nosaa loja                   "
        let banner = Banner(title: title, subtitle: subtitle, image: image, backgroundColor: color)
        banner.springiness = BannerSpringiness.none
        banner.position = BannerPosition.top
        
        banner.didTapBlock = {
            
        }
        
        banner.show(duration: 3.0)
        
    }


    
    
    
}
