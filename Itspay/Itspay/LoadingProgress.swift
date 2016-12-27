//
//  LoadingProgress.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/16/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

var LOADING_PROGRESS_VIEW_TAG = 900

class LoadingProgress {
    static var sharedInstance = LoadingProgress()
    
    var loadingView = UIView()
    
    static func initLoadingView(_ rect: CGRect, isAlphaReduced : Bool) -> UIView {
        let loadingView = UIView(frame: rect)
        
        if isAlphaReduced {
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        } else {
            loadingView.backgroundColor = UIColor.clear
        }
        
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
            LoadingProgress.sharedInstance.loadingView = LoadingProgress.initLoadingView((window?.frame)!, isAlphaReduced: true)
            
            window?.addSubview(LoadingProgress.sharedInstance.loadingView)
        }
    }

    static func startAnimating(in view : UIView, isAlphaReduced : Bool) {
        let loadingView = LoadingProgress.initLoadingView(view.frame, isAlphaReduced: isAlphaReduced)
        loadingView.tag = LOADING_PROGRESS_VIEW_TAG
        view.addSubview(loadingView)
    }
    
    static func stopAnimating() {
        LoadingProgress.sharedInstance.loadingView.removeFromSuperview()
    }
    
    static func stopAnimating(in view : UIView) {
        for subview in view.subviews {
            if subview.tag == LOADING_PROGRESS_VIEW_TAG {
                subview.removeFromSuperview()
            }
        }
    }
}
