//
//  Caracteristicas.swift
//
//  Created by Arthur Augusto Sousa Marques on 12/29/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Caracteristicas: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let idCaracteristicaReferencia = "idCaracteristicaReferencia"
    static let valor = "valor"
    static let idReferenciaSKU = "idReferenciaSKU"
    static let nome = "nome"
  }

  // MARK: Properties
  public var idCaracteristicaReferencia: Int?
  public var valor: String?
  public var idReferenciaSKU: Int?
  public var nome: String?

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
    idCaracteristicaReferencia = json[SerializationKeys.idCaracteristicaReferencia].int
    valor = json[SerializationKeys.valor].string
    idReferenciaSKU = json[SerializationKeys.idReferenciaSKU].int
    nome = json[SerializationKeys.nome].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = idCaracteristicaReferencia { dictionary[SerializationKeys.idCaracteristicaReferencia] = value }
    if let value = valor { dictionary[SerializationKeys.valor] = value }
    if let value = idReferenciaSKU { dictionary[SerializationKeys.idReferenciaSKU] = value }
    if let value = nome { dictionary[SerializationKeys.nome] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.idCaracteristicaReferencia = aDecoder.decodeObject(forKey: SerializationKeys.idCaracteristicaReferencia) as? Int
    self.valor = aDecoder.decodeObject(forKey: SerializationKeys.valor) as? String
    self.idReferenciaSKU = aDecoder.decodeObject(forKey: SerializationKeys.idReferenciaSKU) as? Int
    self.nome = aDecoder.decodeObject(forKey: SerializationKeys.nome) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(idCaracteristicaReferencia, forKey: SerializationKeys.idCaracteristicaReferencia)
    aCoder.encode(valor, forKey: SerializationKeys.valor)
    aCoder.encode(idReferenciaSKU, forKey: SerializationKeys.idReferenciaSKU)
    aCoder.encode(nome, forKey: SerializationKeys.nome)
  }

}
