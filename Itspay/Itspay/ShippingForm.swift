//
//  ShippingForm.swift
//
//  Created by Arthur Augusto Sousa Marques on 1/6/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ShippingForm: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let titulo = "titulo"
    static let descricao = "descricao"
    static let valor = "valor"
  }

  // MARK: Properties
  public var titulo: String?
  public var descricao: String?
  public var valor: Float?

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
    titulo = json[SerializationKeys.titulo].string
    descricao = json[SerializationKeys.descricao].string
    valor = json[SerializationKeys.valor].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = titulo { dictionary[SerializationKeys.titulo] = value }
    if let value = descricao { dictionary[SerializationKeys.descricao] = value }
    if let value = valor { dictionary[SerializationKeys.valor] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.titulo = aDecoder.decodeObject(forKey: SerializationKeys.titulo) as? String
    self.descricao = aDecoder.decodeObject(forKey: SerializationKeys.descricao) as? String
    self.valor = aDecoder.decodeObject(forKey: SerializationKeys.valor) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(titulo, forKey: SerializationKeys.titulo)
    aCoder.encode(descricao, forKey: SerializationKeys.descricao)
    aCoder.encode(valor, forKey: SerializationKeys.valor)
  }

}
