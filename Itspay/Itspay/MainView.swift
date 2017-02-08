//
//  MainView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/13/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

class MainView: UIViewController {
    
    @IBOutlet weak var ivLogoClient: UIImageView!
    @IBOutlet weak var ivBackGround: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let launchScreenView = instantiateFrom("General", identifier: "LaunchScreenView") as! LaunchScreenView
        launchScreenView.startLaunchScreen(in: self)
        
        ivLogoClient.image = UIImage(named: LOGO_CLIENT)
        ivBackGround.image = UIImage(named: BACKGROUND_CLIENT)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}
