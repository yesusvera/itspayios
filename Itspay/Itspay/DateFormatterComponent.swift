//
//  DateFormatComponent.swift
//
//  Created by Arthur Marques on 4/7/16.
//  Copyright © 2016 ItsPay. All rights reserved.
//

import UIKit

extension DateFormatter {
    static func dateWith(_ format : String, from timestamp : Double) -> String? {
        let date = Date(timeIntervalSince1970: timestamp/1000)
        
        return DateFormatter.stringWith("dd/MM/yyyy", from : date)
    }
    
    static func dateWith(_ format : String, string : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: string)
    }
    
    static func stringWith(_ format : String, from date : Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func stringWith(_ format : String, string : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: string) {
            return dateFormatter.string(from: date)
        }
        return string
    }
    
    static func stringDateTimestampWith(_ format : String, from string : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: string) {
            return "\(date.timeIntervalSince1970*1000)"
        }
        return string
    }
    
    static func getDateWithDetailedDescriptionFrom(_ date : Date) -> String {
        let dateFormatterDay = DateFormatter()
        dateFormatterDay.dateFormat = "dd"
        
        let day = dateFormatterDay.string(from: date)
        
        let dateFormatterMonth = DateFormatter()
        dateFormatterMonth.dateFormat = "MMMM"
        
        let month = NSLocalizedString(dateFormatterMonth.string(from: date).uppercased(), comment: "")
        
        let dateFormatterYear = DateFormatter()
        dateFormatterYear.dateFormat = "yyyy"
        
        let year = dateFormatterYear.string(from: date)
        
        return "\(day) de \(month) de \(year)"
    }
    
    static func getDateWithDetailedDescription(_ dateString : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let dateFormatterDay = DateFormatter()
            dateFormatterDay.dateFormat = "dd"
            
            let day = dateFormatterDay.string(from: date)
            
            let dateFormatterMonth = DateFormatter()
            dateFormatterMonth.dateFormat = "MMMM"
            
            let month = NSLocalizedString(dateFormatterMonth.string(from: date).uppercased(), comment: "")
            
            let dateFormatterYear = DateFormatter()
            dateFormatterYear.dateFormat = "yyyy"
            
            let year = dateFormatterYear.string(from: date)
            
            return "\(day) de \(month) de \(year)"
        }
        return ""
    }
}

extension Date {
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        var isGreater = false
        
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        return isGreater
    }
    
    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        var isLess = false
        
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        return isLess
    }
    
    func equalToDate(_ dateToCompare: Date) -> Bool {
        var isEqualTo = false
        
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        return isEqualTo
    }
    
    func addDays(_ daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        return dateWithDaysAdded
    }
    
    func addYears(_ yearsToAdd: Int) -> Date {
        let components = DateComponents()
        (components as NSDateComponents).setValue(yearsToAdd, forComponent: .year)
        let dateWithYearsAdded:Date = (Calendar.current as NSCalendar).date(byAdding: components, to: self, options: NSCalendar.Options.init(rawValue: 0))!
        return dateWithYearsAdded
    }
    
    func addHours(_ hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        return dateWithHoursAdded
    }
    
    func yearsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.year, from: date, to: self, options: []).year!
    }
    
    func monthsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.month, from: date, to: self, options: []).month!
    }
    
    func weeksFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.weekOfYear, from: date, to: self, options: []).weekOfYear!
    }
    
    func daysFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.day, from: date, to: self, options: []).day!
    }
    
    func hoursFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.hour, from: date, to: self, options: []).hour!
    }
    
    func minutesFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.minute, from: date, to: self, options: []).minute!
    }
    
    func secondsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.second, from: date, to: self, options: []).second!
    }
    
    func nanosecondsFrom(_ date:Date) -> Int{
        return (Calendar.current as NSCalendar).components(.nanosecond, from: date, to: self, options: []).second!
    }
    
    func offsetFrom(_ date:Date) -> String {
        if yearsFrom(date)   > 0 { return "\(yearsFrom(date))y"   }
        if monthsFrom(date)  > 0 { return "\(monthsFrom(date))M"  }
        if weeksFrom(date)   > 0 { return "\(weeksFrom(date))w"   }
        if daysFrom(date)    > 0 { return "\(daysFrom(date))d"    }
        if hoursFrom(date)   > 0 { return "\(hoursFrom(date))h"   }
        if minutesFrom(date) > 0 { return "\(minutesFrom(date))m" }
        if secondsFrom(date) > 0 { return "\(secondsFrom(date))s" }
        return ""
    }
}
