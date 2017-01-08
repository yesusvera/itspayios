//
//  DataHoraPedido.swift
//
//  Created by Arthur Augusto Sousa Marques on 1/7/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DataHoraPedido: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let dayOfWeek = "dayOfWeek"
    static let hour = "hour"
    static let dayOfMonth = "dayOfMonth"
    static let chronology = "chronology"
    static let monthValue = "monthValue"
    static let second = "second"
    static let year = "year"
    static let month = "month"
    static let dayOfYear = "dayOfYear"
    static let minute = "minute"
    static let nano = "nano"
  }

  // MARK: Properties
  public var dayOfWeek: String?
  public var hour: Int?
  public var dayOfMonth: Int?
  public var chronology: Chronology?
  public var monthValue: Int?
  public var second: Int?
  public var year: Int?
  public var month: String?
  public var dayOfYear: Int?
  public var minute: Int?
  public var nano: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    dayOfWeek = json[SerializationKeys.dayOfWeek].string
    hour = json[SerializationKeys.hour].int
    dayOfMonth = json[SerializationKeys.dayOfMonth].int
    chronology = Chronology(json: json[SerializationKeys.chronology])
    monthValue = json[SerializationKeys.monthValue].int
    second = json[SerializationKeys.second].int
    year = json[SerializationKeys.year].int
    month = json[SerializationKeys.month].string
    dayOfYear = json[SerializationKeys.dayOfYear].int
    minute = json[SerializationKeys.minute].int
    nano = json[SerializationKeys.nano].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = dayOfWeek { dictionary[SerializationKeys.dayOfWeek] = value }
    if let value = hour { dictionary[SerializationKeys.hour] = value }
    if let value = dayOfMonth { dictionary[SerializationKeys.dayOfMonth] = value }
    if let value = chronology { dictionary[SerializationKeys.chronology] = value.dictionaryRepresentation() }
    if let value = monthValue { dictionary[SerializationKeys.monthValue] = value }
    if let value = second { dictionary[SerializationKeys.second] = value }
    if let value = year { dictionary[SerializationKeys.year] = value }
    if let value = month { dictionary[SerializationKeys.month] = value }
    if let value = dayOfYear { dictionary[SerializationKeys.dayOfYear] = value }
    if let value = minute { dictionary[SerializationKeys.minute] = value }
    if let value = nano { dictionary[SerializationKeys.nano] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.dayOfWeek = aDecoder.decodeObject(forKey: SerializationKeys.dayOfWeek) as? String
    self.hour = aDecoder.decodeObject(forKey: SerializationKeys.hour) as? Int
    self.dayOfMonth = aDecoder.decodeObject(forKey: SerializationKeys.dayOfMonth) as? Int
    self.chronology = aDecoder.decodeObject(forKey: SerializationKeys.chronology) as? Chronology
    self.monthValue = aDecoder.decodeObject(forKey: SerializationKeys.monthValue) as? Int
    self.second = aDecoder.decodeObject(forKey: SerializationKeys.second) as? Int
    self.year = aDecoder.decodeObject(forKey: SerializationKeys.year) as? Int
    self.month = aDecoder.decodeObject(forKey: SerializationKeys.month) as? String
    self.dayOfYear = aDecoder.decodeObject(forKey: SerializationKeys.dayOfYear) as? Int
    self.minute = aDecoder.decodeObject(forKey: SerializationKeys.minute) as? Int
    self.nano = aDecoder.decodeObject(forKey: SerializationKeys.nano) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(dayOfWeek, forKey: SerializationKeys.dayOfWeek)
    aCoder.encode(hour, forKey: SerializationKeys.hour)
    aCoder.encode(dayOfMonth, forKey: SerializationKeys.dayOfMonth)
    aCoder.encode(chronology, forKey: SerializationKeys.chronology)
    aCoder.encode(monthValue, forKey: SerializationKeys.monthValue)
    aCoder.encode(second, forKey: SerializationKeys.second)
    aCoder.encode(year, forKey: SerializationKeys.year)
    aCoder.encode(month, forKey: SerializationKeys.month)
    aCoder.encode(dayOfYear, forKey: SerializationKeys.dayOfYear)
    aCoder.encode(minute, forKey: SerializationKeys.minute)
    aCoder.encode(nano, forKey: SerializationKeys.nano)
  }

}
