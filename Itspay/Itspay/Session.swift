//
//  Session.swift
//
//  Created by Arthur Marques on 11/3/15.
//  Copyright © 2015 ItsPay. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "touchesBegan"), object: nil)
    }
}

class Session : UIViewController {
    static let sharedInstance = Session()

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var timerSession : Timer!
    var timerLabelSession : Timer!
    var timerCount = Repository.getSessionTimerCount()
    
    var dateEnterBackground = Date()
    var dateResignActive = Date()
    
    var arrayTimers = [Timer]()
    
    func startSession() {
        invalidateTimers()
        arrayTimers = [Timer]()
        timerCount = Repository.getSessionTimerCount()
        timerSession = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Session.updateSession), userInfo: nil, repeats: true)
        arrayTimers.append(timerSession)
    }
    
    func showFinishingSessionView() {
        if Repository.isLogOn() {
            print("FINISHED SESSION")
        }
        
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SessionTimerView")
        
        let mainWindow = UIApplication.shared.keyWindow
        
        mainWindow?.addSubview(viewController.view)
    }
    
    func updateSession() {
//        print("Timer Count: \(timerCount)")
        
        if(timerCount > 0) {
            if timerCount == 31 {
                showFinishingSessionView()
            }
            
            timerCount -= 1
        }
    }
    
    func expireSession() {
//        LoginController().logout(LoginController.sharedInstance.usuario, viewController : nil, handlerJsonResult: { (jsonResult) -> () in
//            print("USER LOGGED OUT")
//        })
        
        invalidateTimers()
        
        timerLabelSession.invalidate()
        
//        let storyboard = UIStoryboard(name: "Login", bundle: nil)
//        let navigationController = storyboard.instantiateViewControllerWithIdentifier("LoginNavigationController")
//        appDelegate.window?.rootViewController = navigationController
    }
    
    func touchesBegan(_ notification : Notification) {
        timerCount = Repository.getSessionTimerCount()
    }
    
    func invalidateTimers() {
        for timer in arrayTimers {
            timer.invalidate()
        }
        arrayTimers.removeAll()
    }
    
    func updateLabelSession(_ label : UILabel) {
        timerLabelSession = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(Session.updateLabelSessionTimer(_:)), userInfo: label, repeats: true)
    }
    
    func updateLabelSessionTimer(_ timer : Timer) {
        let label = timer.userInfo as! UILabel
        label.text = "Sessao \(Int(Session.sharedInstance.timerCount)/60)min\(Int(Session.sharedInstance.timerCount) % 60)"
    }
}
