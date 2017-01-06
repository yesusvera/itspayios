//
//  TipoEndereco.swift
//
//  Created by Arthur Augusto Sousa Marques on 1/6/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class TipoEndereco: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let aplicabilidade = "aplicabilidade"
    static let idTipoEndereco = "idTipoEndereco"
    static let descTipoEndereco = "descTipoEndereco"
  }

  // MARK: Properties
  public var aplicabilidade: Int?
  public var idTipoEndereco: Int?
  public var descTipoEndereco: String?

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
    aplicabilidade = json[SerializationKeys.aplicabilidade].int
    idTipoEndereco = json[SerializationKeys.idTipoEndereco].int
    descTipoEndereco = json[SerializationKeys.descTipoEndereco].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = aplicabilidade { dictionary[SerializationKeys.aplicabilidade] = value }
    if let value = idTipoEndereco { dictionary[SerializationKeys.idTipoEndereco] = value }
    if let value = descTipoEndereco { dictionary[SerializationKeys.descTipoEndereco] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.aplicabilidade = aDecoder.decodeObject(forKey: SerializationKeys.aplicabilidade) as? Int
    self.idTipoEndereco = aDecoder.decodeObject(forKey: SerializationKeys.idTipoEndereco) as? Int
    self.descTipoEndereco = aDecoder.decodeObject(forKey: SerializationKeys.descTipoEndereco) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(aplicabilidade, forKey: SerializationKeys.aplicabilidade)
    aCoder.encode(idTipoEndereco, forKey: SerializationKeys.idTipoEndereco)
    aCoder.encode(descTipoEndereco, forKey: SerializationKeys.descTipoEndereco)
  }

}
