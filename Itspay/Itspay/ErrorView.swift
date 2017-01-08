//
//  ErrorView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/8/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class ErrorView : UIView {
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    @IBInspectable var msgError : String? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var image : UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var imageBackgroundColor : UIColor? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var imageTintColor : UIColor? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var imageCornerRadius : CGFloat? {
        didSet {
            updateView()
        }
    }
    
    var errorView : ErrorView!
    
    var height = CGFloat(150)
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ErrorView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
    
    func instantiate(in view : UIView, addToView : Bool) {
        self.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        self.center = view.center
        
        errorView = ErrorView.instanceFromNib() as! ErrorView
        errorView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        errorView.removeFromSuperview()
        self.addSubview(errorView)
        
        errorView.isHidden = true
        self.isHidden = true
        
        if addToView {
            self.removeFromSuperview()
            view.addSubview(self)
        }
    }
    
    func updateView() {
        if errorView != nil {
            if errorView.labelError != nil {
                if let msgError = msgError {
                    errorView.labelError.text = msgError
                    
                    if msgError != "" {
                        self.isHidden = false
                        errorView.isHidden = false
                    } else {
                        self.isHidden = true
                        errorView.isHidden = true
                    }
                }
            }
            
            if errorView.imageView != nil {
                if let image = image {
                    errorView.imageView.image = image
                }
                
                if let imageBackgroundColor = imageBackgroundColor {
                    errorView.imageView.backgroundColor = imageBackgroundColor
                }
                
                if let imageTintColor = imageTintColor {
                    errorView.imageView.image = errorView.imageView.image?.withRenderingMode(.alwaysTemplate)
                    errorView.imageView.tintColor = imageTintColor
                }
                
                if let imageCornerRadius = imageCornerRadius {
                    errorView.imageView.layer.masksToBounds = true
                    errorView.imageView.layer.cornerRadius = imageCornerRadius
                }
            }
            
            errorView.setNeedsDisplay()
        }
        
        setNeedsDisplay()
    }
}
