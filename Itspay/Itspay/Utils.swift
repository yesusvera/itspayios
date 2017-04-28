//
//  Utils.swift
//  Itspay
//
//  Created by Junior Braga on 27/04/17.
//  Copyright © 2017 Compilab. All rights reserved.
//

import UIKit

class Utils {

    static func GetDateFromString(DateStr: String)-> String {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let DateArray = DateStr.components(separatedBy: "/")
        let components = NSDateComponents()
        components.year = Int(DateArray[2])!
        components.month = Int(DateArray[1])!
        components.day = Int(DateArray[0])!
        
        let date = calendar?.date(from: components as DateComponents)
        
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd"
        
        let stringOfDate = dateFormate.string(from: date!)
        print(stringOfDate)
        
        return stringOfDate
    }
}
