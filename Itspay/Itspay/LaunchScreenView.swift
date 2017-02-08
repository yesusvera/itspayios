//
//  LaunchScreenView.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 1/1/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit
import Spring

class LaunchScreenView: UIViewController {
    @IBOutlet weak var springView: SpringView!
    @IBOutlet weak var ivBackGround: UIImageView!
    
    @IBOutlet weak var imageView: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func startLaunchScreen(in viewController : UIViewController) {
        viewController.view.addSubview(self.view)
        
        imageView.image = UIImage(named: LOGO_CLIENT)
        ivBackGround.image = UIImage(named: BACKGROUND_CLIENT)
        
        springView.animate()
        
        
        Timer.scheduledTimer(timeInterval: Double(springView.duration), target: self, selector: #selector(self.stopLaunchScreen), userInfo: nil, repeats: false)
    }
    
    func stopLaunchScreen() {
        self.view.removeFromSuperview()
    }
}
