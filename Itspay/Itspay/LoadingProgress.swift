//
//  LoadingProgress.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/16/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class LoadingProgress {
    static var sharedInstance = LoadingProgress()
    
    var loadingView = UIView()
    
    static func initLoadingView(_ rect: CGRect) -> UIView {
        let loadingView = UIView(frame: rect)
        
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let activityIndicator = UIActivityIndicatorView()

        activityIndicator.center = loadingView.center
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = UIColor.white
        activityIndicator.startAnimating()
        
        loadingView.addSubview(activityIndicator)
        
        return loadingView
    }
    
    static func startAnimatingInWindow() {
        if let window = appDelegate.window {
            LoadingProgress.sharedInstance.loadingView = LoadingProgress.initLoadingView((window?.frame)!)
            
            window?.addSubview(LoadingProgress.sharedInstance.loadingView)
        }
    }

    static func startAnimating(in view : UIView) {
        LoadingProgress.sharedInstance.loadingView = LoadingProgress.initLoadingView(view.frame)
        
        view.addSubview(LoadingProgress.sharedInstance.loadingView)
    }
    
    static func stopAnimating() {
        LoadingProgress.sharedInstance.loadingView.removeFromSuperview()
    }
}
