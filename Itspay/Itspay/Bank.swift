//
//  Bank.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/22/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Bank: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let descBanco = "descBanco"
    static let idBanco = "idBanco"
  }

  // MARK: Properties
  public var descBanco: String?
  public var idBanco: Int?

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
    descBanco = json[SerializationKeys.descBanco].string
    idBanco = json[SerializationKeys.idBanco].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = descBanco { dictionary[SerializationKeys.descBanco] = value }
    if let value = idBanco { dictionary[SerializationKeys.idBanco] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.descBanco = aDecoder.decodeObject(forKey: SerializationKeys.descBanco) as? String
    self.idBanco = aDecoder.decodeObject(forKey: SerializationKeys.idBanco) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(descBanco, forKey: SerializationKeys.descBanco)
    aCoder.encode(idBanco, forKey: SerializationKeys.idBanco)
  }

}
