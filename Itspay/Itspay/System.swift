//
//  System.swift
//  Itspay
//
//  Created by Arthur Augusto Sousa Marques on 12/13/16.
//  Copyright © 2016 Compilab. All rights reserved.
//

import UIKit

//Screen Related Values
let SCREEN_WIDTH = UIApplication.shared.keyWindow!.frame.size.width
let SCREEN_HEIGHT = UIApplication.shared.keyWindow!.frame.size.height

open class System: NSObject {
    static func getOperatingSystemVersion() -> String {
        let os = ProcessInfo().operatingSystemVersion
        
        return "\(os.majorVersion).\(os.minorVersion).\(os.patchVersion)"
    }
    
    static func getAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        
        if let version = dictionary["CFBundleShortVersionString"] as? String {
            return version
        }
        return ""
    }
    
    static func getBuildVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        
        if let build = dictionary["CFBundleVersion"] as? String {
            return build
        }
        return ""
    }
    
    static func getUDID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    static func isSystemVersionLessThan(_ majorVersion: Int) -> Bool {
        let os = ProcessInfo().operatingSystemVersion
        if os.majorVersion < majorVersion {
            return true
        }
        return false
    }
    
    static func getCurrentDeviceModel() -> String {
        return UIDevice.current.localizedModel
    }
    
    static func getCurrentDeviceName() -> String {
        return UIDevice.current.name
    }
}
