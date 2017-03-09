//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let dateFormate = DateFormatter()


//dateFormate.dateFormat = "yyyy-MM-dd"
//let stringOfDate = dateFormate.date(from: "15/10/1994")
//print(stringOfDate)
//

//var dateString = "15/10/1994"
//var dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy-MM-dd"
//let s = dateFormatter.date(from: dateString)
//print(s)
////

func GetDateFromString(DateStr: String)-> String {
    let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
    let DateArray = DateStr.components(separatedBy: "/")
    let components = NSDateComponents()
    components.year = Int(DateArray[2])!
    components.month = Int(DateArray[1])!
    components.day = Int(DateArray[0])! + 1
    
    let date = calendar?.date(from: components as DateComponents)
    
    let dateFormate = DateFormatter()
    dateFormate.dateFormat = "yyyy-MM-dd"
    
       let stringOfDate = dateFormate.string(from: date!)
    print(stringOfDate)
    
    return stringOfDate
}


GetDateFromString(DateStr: "15/10/1994")



//let dateFormate = DateFormatter()
//dateFormate.dateFormat = "MM-dd-yyyy HH:mm"
//let date = "15/10/1994"
//let stringOfDate = dateFormate.date(from: date)
//print(stringOfDate)

//var dateString = GetDateFromString(DateStr: "15/10/1994")
//var dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy-MM-dd"
//let s = dateFormatter.date(from: dateString)
//print(s)

//dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "yyyy-MM-dd"
// dateFormatter.date(from: dateString)
