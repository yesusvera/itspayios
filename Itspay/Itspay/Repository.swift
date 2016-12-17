//
//  HBKUtil.swift
//
//  Created by Arthur Augusto Sousa Marques on 8/31/15.
//  Copyright (c) 2015 bb. All rights reserved.
//

import Foundation
import UIKit

let serviceMainRootProdKey = "mainServer"
let serviceMainRootCustomUrlKey = "customUrl"

var pathServices = Bundle.main.path(forResource: "services", ofType: "plist")
var pathConfig = Bundle.main.path(forResource: "config", ofType: "plist")
var pathMocks = Bundle.main.path(forResource: "mocks", ofType: "plist")

var newHostIp : String?

enum PListType : Int {
    case services
    case config
    case docs
    case mocks
}

class Repository {
    //MARK: ROOT URL
    static func serviceMainRoot() -> String {
        //Settings Bundle - Check if 'environment' is set, and use url key if true
        let standardUserDefaults = UserDefaults.standard
        if let environmentDict = standardUserDefaults.dictionary(forKey: "environment") {
            if let url = environmentDict["url"] as? String {
                return url
            }
        }
        return serviceMainRootProdKey //Default, if not set
    }
    
    static func setNewHostIp(_ ip: String) {
        newHostIp = ip
    }
    
    static func getPListValue(_ plist : PListType, key: String) -> String {
        var path : String?
        
        if plist == .services {
            path = pathServices
        } else if plist == .config {
            path = pathConfig
        } else if plist == .mocks {
            path = pathMocks
        }
        
        if let path = path {
            if let serviceDict = NSDictionary(contentsOfFile: path) {
                return serviceDict.object(forKey: key) as! String
            }
        }
        
        return ""
    }
    
    static func createServiceURLFromPListValue(_ plist : PListType, key: String) -> String {
        var url = ""
        
        if pathServices != nil {
            let rootKey = serviceMainRoot() //Get root key
            if rootKey == serviceMainRootCustomUrlKey { //Check if its chosen to be custom
                url = getCustomUrlFromSettingsBundle() //Get custom Url vlaue
            } else { //Get Url value by root key
                url = Repository.getPListValue(plist, key: rootKey)
            }
            
            url += "/"
            url += Repository.getPListValue(plist, key: key)
        }
        
        return url
    }
    
    static func getCustomUrlFromSettingsBundle() -> String {
        //Return defined custom URL
        let standardUserDefaults = UserDefaults.standard
        if let customUrl = standardUserDefaults.value(forKey: "customUrl") as? String {
            return customUrl
        }
        return ""
    }
    
    //MARK: WEB LINKS
    static func getAppStorePath() -> String {
        var serviceDict: NSDictionary?
        var url = ""
        
        if pathServices != nil {
            serviceDict = NSDictionary(contentsOfFile: pathServices!)
            url += "\(serviceDict?.object(forKey: "InvestimentoBBAppStore") as! String)"
        }
        
        return url
    }
    
    static func getReviewPageAppStorePath() -> String {
        return "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1120718299"
    }
    
    //MARK: SESSION
    static func getSessionTimerCount() -> Double {
        var timerCount = Double(30)
        var configDict: NSDictionary?
        
        if pathConfig != nil {
            configDict = NSDictionary(contentsOfFile: pathConfig!)
            timerCount = configDict?.object(forKey: "timerSessionCount") as! Double
        }
        
        return timerCount
    }
    
    static func getReturnSessionTimerCount() -> Double {
        var timerCount = Double(30)
        var configDict: NSDictionary?
        
        if pathConfig != nil {
            configDict = NSDictionary(contentsOfFile: pathConfig!)
            timerCount = configDict?.object(forKey: "timerReturnSessionCount") as! Double
        }
        
        return timerCount
    }
    
    //MARK: CONFIG
    static func isDebugOn() -> Bool {
        var configDict: NSDictionary?
        
        if pathConfig != nil {
            configDict = NSDictionary(contentsOfFile: pathConfig!)
            let isDebugOn = configDict?.object(forKey: "isDebugOn") as! Bool
            if isDebugOn == true {
                return true
            }
        }
        
        return false
    }
    
    //MARK: CONFIG
    static func isLogOn() -> Bool {
        var configDict: NSDictionary?
        
        if pathConfig != nil {
            configDict = NSDictionary(contentsOfFile: pathConfig!)
            let isLogOn = configDict?.object(forKey: "isLogOn") as! Bool
            if isLogOn == true {
                return true
            }
        }
        
        return false
    }
    
    static func isMockOn() -> Bool {
        var configDict: NSDictionary?
        
        if pathConfig != nil {
            configDict = NSDictionary(contentsOfFile: pathConfig!)
            let isMockOn = configDict?.object(forKey: "isMockOn") as! Bool
            if isMockOn == true {
                return true
            }
        }
        
        return false
    }
    
    static func isMutableIp() -> Bool {
        var configDict: NSDictionary?
        
        if pathConfig != nil {
            configDict = NSDictionary(contentsOfFile: pathConfig!)
            let isMutableIp = configDict?.object(forKey: "isMutableIp") as! Bool
            if isMutableIp == true {
                return true
            }
        }
        
        return false
    }
    
    //To use Production (true) or Development (false) Root URL
    static func useProductionRootURL() -> Bool {
        var configDict: NSDictionary?
        
        if pathConfig != nil {
            configDict = NSDictionary(contentsOfFile: pathConfig!)
            let useProductionRootURL = configDict?.object(forKey: "useProductionRootURL") as! Bool
            if useProductionRootURL == true {
                return true
            }
        }
        
        return false
    }
}
