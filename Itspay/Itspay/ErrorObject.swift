//
//  ErrorObject.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/14/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ErrorObject: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  fileprivate struct SerializationKeys {
    static let fieldErrors = "fieldErrors"
    static let code = "code"
    static let msg = "msg"
  }

  // MARK: Properties
  public var fieldErrors: [FieldErrors]?
  public var code: String?
  public var msg: String?

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
    if let items = json[SerializationKeys.fieldErrors].array { fieldErrors = items.map { FieldErrors(json: $0) } }
    code = json[SerializationKeys.code].string
    msg = json[SerializationKeys.msg].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = fieldErrors { dictionary[SerializationKeys.fieldErrors] = value.map { $0.dictionaryRepresentation() } }
    if let value = code { dictionary[SerializationKeys.code] = value }
    if let value = msg { dictionary[SerializationKeys.msg] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.fieldErrors = aDecoder.decodeObject(forKey: SerializationKeys.fieldErrors) as? [FieldErrors]
    self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? String
    self.msg = aDecoder.decodeObject(forKey: SerializationKeys.msg) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(fieldErrors, forKey: SerializationKeys.fieldErrors)
    aCoder.encode(code, forKey: SerializationKeys.code)
    aCoder.encode(msg, forKey: SerializationKeys.msg)
  }

}
