//
//  FieldErrors.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/14/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class FieldErrors: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let msg = "msg"
    static let field = "field"
    static let code = "code"
    static let resource = "resource"
  }

  // MARK: Properties
  public var msg: String?
  public var field: String?
  public var code: String?
  public var resource: String?

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
    msg = json[SerializationKeys.msg].string
    field = json[SerializationKeys.field].string
    code = json[SerializationKeys.code].string
    resource = json[SerializationKeys.resource].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = msg { dictionary[SerializationKeys.msg] = value }
    if let value = field { dictionary[SerializationKeys.field] = value }
    if let value = code { dictionary[SerializationKeys.code] = value }
    if let value = resource { dictionary[SerializationKeys.resource] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.msg = aDecoder.decodeObject(forKey: SerializationKeys.msg) as? String
    self.field = aDecoder.decodeObject(forKey: SerializationKeys.field) as? String
    self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? String
    self.resource = aDecoder.decodeObject(forKey: SerializationKeys.resource) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(msg, forKey: SerializationKeys.msg)
    aCoder.encode(field, forKey: SerializationKeys.field)
    aCoder.encode(code, forKey: SerializationKeys.code)
    aCoder.encode(resource, forKey: SerializationKeys.resource)
  }

}
